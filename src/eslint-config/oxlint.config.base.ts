import type { OxlintConfig } from "oxlint";

import { defineConfig } from "oxlint";

export const newOxlintConfig = (): OxlintConfig =>
  defineConfig({
    categories: {
      correctness: "deny",
      nursery: "deny",
      pedantic: "deny",
      perf: "deny",
      restriction: "deny",
      style: "deny",
      suspicious: "deny",
    },
    plugins: [
      "eslint",
      "react",
      "unicorn",
      "typescript",
      "oxc",
      "import",
      "jsdoc",
      "vitest",
      "jsx-a11y",
      "react-perf",
      "promise",
      "node",
    ],
    rules: {
      "jsx-filename-extension": "allow",
      "no-default-export": "allow",
      "no-duplicate-imports": "allow",
      "no-magic-numbers": "allow",
      "no-multi-comp": "allow",
      "no-named-export": "allow",
      "no-ternary": "allow",
      "no-unassigned-import": ["deny", { allow: ["**/*.css"] }],
      "no-undefined": "allow",
      "only-export-components": "allow",
      "prefer-default-export": "allow",
      "react-in-jsx-scope": "allow",
      "sort-imports": "allow",
    },
  } satisfies OxlintConfig);
