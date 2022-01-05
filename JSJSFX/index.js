import fs from "fs/promises";

await JSFX({
  name: "leafac_Volume (Gain)",
  components: [
    {
      sliders: [
        {
          identifier: 1,
          variable: "volume",
          initial: 0,
          minimum: -60,
          maximum: 60,
          step: 1,
          description: "Volume (dB)",
        },
        {
          identifier: 2,
          variable: "volume.hidden",
          initial: 0,
          minimum: -60,
          maximum: 60,
          step: 1,
          description: "Not Volume (dB)",
          hidden: true,
        },
      ],
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
  // Check for repeated slider identifiers.
  const sliderIdentifiers = new Set();
  for (const { sliders } of components)
    if (sliders !== undefined)
      for (const { identifier } of sliders)
        if (sliderIdentifiers.has(identifier))
          throw new Error(`Repeated slider identifier ${identifier}`);
        else sliderIdentifiers.add(identifier);

  // Output the JSFX
  await fs.writeFile(
    `/Users/leafac/Library/Application Support/REAPER/Effects/leafac/${name}.jsfx`,
    `desc:${name}

${components
  .map((component) =>
    component.sliders === undefined
      ? ``
      : component.sliders
          .map(
            ({
              identifier,
              variable,
              initial,
              minimum,
              maximum,
              step,
              description,
              hidden,
            }) =>
              `slider${identifier}:${variable}=${initial}<${minimum},${maximum},${step}>${
                hidden === true ? `-` : ``
              }${description}`
          )
          .join("\n")
  )
  .join("")}

${["init", "slider", "serialize", "block", "sample", "gfx"]
  .map(
    (JSFXSection) =>
      `
@${JSFXSection}
"NOOP";
${components.map((component) => component[JSFXSection] ?? ``).join("")}
`
  )
  .join("")}
`
  );
}
