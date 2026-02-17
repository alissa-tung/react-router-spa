import type { Config } from "eslint/config";

import react from "@eslint-react/eslint-plugin";
import parser from "@typescript-eslint/parser";
import tailwindcss from "eslint-plugin-better-tailwindcss";
import reactHooks from "eslint-plugin-react-hooks";
import { defineConfig, globalIgnores } from "eslint/config";

export const newEslintConfig = (): Config[] =>
  defineConfig([
    react.configs["strict-type-checked"],
    reactHooks.configs.flat["recommended-latest"],
    tailwindcss.configs["recommended-error"],

    globalIgnores(["./build", "./.react-router"]),
    {
      files: ["**/*.ts", "**/*.tsx"],
      languageOptions: {
        parser,
        parserOptions: {
          projectService: true,
        },
      },
      rules: {
        "@eslint-react/naming-convention/component-name": "error",
      },
    },
  ]);
