import react from "@eslint-react/eslint-plugin";
import js from "@eslint/js";
import tailwindcss from "eslint-plugin-better-tailwindcss";
import { importX } from "eslint-plugin-import-x";
import jsx from "eslint-plugin-react";
import * as reactCompiler from "eslint-plugin-react-compiler";
import reactHooks from "eslint-plugin-react-hooks";
import { reactRefresh } from "eslint-plugin-react-refresh";
import { type Config, defineConfig, globalIgnores } from "eslint/config";
import * as ts from "typescript-eslint";

const rules: Config["rules"] = {
  ...{
    "better-tailwindcss/no-unregistered-classes": "off",
  },
  ...{
    "prefer-arrow-callback": "error",
    "no-param-reassign": "error",
    "no-var": "error",
    "prefer-const": "error",
    eqeqeq: "error",
    "import-x/first": "error",
    "import-x/no-duplicates": "error",
    "@typescript-eslint/naming-convention": [
      "error",
      {
        selector: "function",
        format: ["camelCase", "PascalCase"],
      },
    ],
    "@typescript-eslint/prefer-readonly": "error",
    "@typescript-eslint/switch-exhaustiveness-check": "error",
    "@typescript-eslint/no-base-to-string": "error",
    "@typescript-eslint/consistent-type-exports": "error",
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/no-import-type-side-effects": "error",
    "@typescript-eslint/no-misused-promises": [
      "error",
      {
        checksVoidReturn: {
          attributes: false,
        },
      },
    ],
  },
  ...{
    "react/prop-types": "off",
    "@eslint-react/dom/no-missing-button-type": "error",
    "react-hooks/exhaustive-deps": "error",
    "react/self-closing-comp": "error",
    "react-compiler/react-compiler": "error",
  },
};

export const newEslintConfig = (): Config[] =>
  defineConfig([
    importX.flatConfigs.recommended as unknown as Config,
    importX.flatConfigs.typescript as unknown as Config,
    js.configs.recommended,
    ts.configs.strictTypeChecked,
    ts.configs.stylisticTypeChecked,
    react.configs["strict-type-checked"],
    reactCompiler.configs.recommended,
    reactRefresh.configs.recommended(),
    reactRefresh.configs.vite(),
    reactHooks.configs.flat["recommended-latest"],
    // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
    jsx.configs.flat["recommended"]!,
    // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
    jsx.configs.flat["jsx-runtime"]!,
    tailwindcss.configs["recommended-error"],

    globalIgnores(["./dist", "./build", "./.react-router"]),
    {
      rules,
      files: ["**/*.ts", "**/*.tsx"],

      languageOptions: {
        parserOptions: {
          projectService: true,
        },
      },

      settings: {
        react: {
          version: "detect",
        },
      },
    },
  ]);
