import fs from "fs/promises";

await JSFX({
  name: "leafac_Volume (Gain)",
  components: [
    {
      init: `<initialize waveforms>`,
      sample: `accumulate_sample(waveform, spl0);`,
      gfx: `draw(waveform);`,
    },
    {
      init: `<initialize line graph>`,
      sample: `accumulate_sample(line graph, spl0);`,
      gfx: `draw(line graph);`,
    },
  ],
});

async function JSFX({ name, components }) {
  await fs.writeFile(
    `/Users/leafac/Library/Application Support/REAPER/Effects/leafac/${name}.jsfx`,
    `desc:${name}

${["init", "slider", "serialize", "block", "sample", "gfx"]
  .map(
    (JSFXSection) =>
      `
@${JSFXSection}
"NOOP";
${components
  .flatMap((component) =>
    component[JSFXSection] === undefined ? [] : [component[JSFXSection]]
  )
  .join("")}
`
  )
  .join("")}
`
  );
}
