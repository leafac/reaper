import fs from "fs/promises";

const components = [];

components.push({
  init: `<initialize waveforms>`,
  sample: `accumulate_sample(waveform, spl0);`,
  gfx: `draw(waveform);`,
});

components.push({
  init: `<initialize line graph>`,
  sample: `accumulate_sample(line graph, spl0);`,
  gfx: `draw(line graph);`,
});

const JSFXSections = ["init", "slider", "serialize", "block", "sample", "gfx"];

await fs.writeFile(
  "/Users/leafac/Library/Application Support/REAPER/Effects/leafac/leafac_Volume (Gain).jsfx",
  `desc:leafac_Volume (Gain)

${JSFXSections.map(
  (JSFXSection) =>
    `@${JSFXSection}

"NOOP";

${components.flatMap((component) =>
  component[JSFXSection] === undefined ? [] : [component[JSFXSection]]
).join("\n")}
`
).join("\n")}
`
);
