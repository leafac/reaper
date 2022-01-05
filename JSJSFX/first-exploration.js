import fs from "fs/promises";
import lodash from "lodash";

await fs.writeFile(
  "/Users/leafac/Library/Application Support/REAPER/Effects/leafac/leafac_Stress test - Filters - JSJSFX - With Function Inlining.jsfx",
  `
desc: leafac_Stress test - Filters - JSJSFX - With Function Inlining

@init

frequency = 500;
Q = 0.707;

g = tan($pi * frequency / srate);
k = 1 / Q;
a1 = 1 / (1 + g * (g + k));
a2 = g * a1;
a3 = g * a2;
m0 = 0;
m1 = 0;
m2 = 1;

@sample

${[...new Array(1000).keys()]
  .map((index) => `local.${index}.`)
  .map(
    (local) => `
      ${local}v0 = spl0;
      ${local}v3 = ${local}v0 - ${local}ic2eq;
      ${local}v1 = a1 * ${local}ic1eq + a2 * ${local}v3;
      ${local}v2 = ${local}ic2eq + a2 * ${local}ic1eq + a3 * ${local}v3;
      ${local}ic1eq = 2 * ${local}v1 - ${local}ic1eq;
      ${local}ic2eq = 2 * ${local}v2 - ${local}ic2eq;
      spl0 = m0 * ${local}v0 + m1 * ${local}v1 + m2 * ${local}v2;
    `
  )
  .join("\n")}
`
);

await fs.writeFile(
  "/Users/leafac/Library/Application Support/REAPER/Effects/leafac/leafac_Stress test - Filters - JSJSFX - Without Function Inlining.jsfx",
  `
desc: leafac_Stress test - Filters - JSJSFX - Without Function Inlining

@init

frequency = 500;
Q = 0.707;

g = tan($pi * frequency / srate);
k = 1 / Q;
a1 = 1 / (1 + g * (g + k));
a2 = g * a1;
a3 = g * a2;
m0 = 0;
m1 = 0;
m2 = 1;

function filter_sample(sample) (
  this.v0 = sample;
  this.v3 = this.v0 - this.ic2eq;
  this.v1 = a1 * this.ic1eq + a2 * this.v3;
  this.v2 = this.ic2eq + a2 * this.ic1eq + a3 * this.v3;
  this.ic1eq = 2 * this.v1 - this.ic1eq;
  this.ic2eq = 2 * this.v2 - this.ic2eq;
  m0 * this.v0 + m1 * this.v1 + m2 * this.v2;
);

@sample

${[...new Array(1000).keys()]
  .map(
    (index) => `
      spl0 = filter.${index}.filter_sample(spl0);
    `
  )
  .join("\n")}
`
);

const waveformsCount = 200;
const slicesCount = 10000;
// const waveformsCount = 200;
// const slicesCount = 10000;

await fs.writeFile(
  "/Users/leafac/Library/Application Support/REAPER/Effects/leafac/leafac_Stress test - Waveforms - JSJSFX.jsfx",
  `
desc: leafac_Stress test - Waveforms - JSJSFX

@init

waveforms.samples_per_slice = 5000 * srate * 0.001 / ${slicesCount};
waveforms.samples_per_slice.counter = -1;

@sample

waveforms.samples_per_slice.counter += 1;

waveforms.samples_per_slice.counter == 0 ? (
  ${lodash
    .range(1, waveformsCount + 1)
    .map(
      (waveformIndex) => `
        ${lodash
          .range(slicesCount - 1, 0)
          .map(
            (sliceIndex) => `
            waveform.${waveformIndex}.slice.n_${sliceIndex}.maximum = waveform.${waveformIndex}.slice.n_${
              sliceIndex - 1
            }.maximum;
            waveform.${waveformIndex}.slice.n_${sliceIndex}.minimum = waveform.${waveformIndex}.slice.n_${
              sliceIndex - 1
            }.minimum;
          `
          )
          .join("\n")}

        waveform.${waveformIndex}.slice.n_0.maximum = -99999;
        waveform.${waveformIndex}.slice.n_0.minimum =  99999;
      `
    )
    .join("\n")}
) : (
  ${lodash
    .range(1, waveformsCount + 1)
    .map(
      (waveformIndex) => `
        waveform.${waveformIndex}.slice.n_0.maximum = max(spl0, waveform.${waveformIndex}.slice.n_0.maximum);
        waveform.${waveformIndex}.slice.n_0.minimum = min(spl0, waveform.${waveformIndex}.slice.n_0.minimum);
      `
    )
    .join("\n")}

  waveforms.samples_per_slice.counter == waveforms.samples_per_slice ? waveforms.samples_per_slice.counter = -1;
);

`
);
