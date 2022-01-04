import fs from "fs/promises";

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
  .map(index => `local.${index}.`)
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
