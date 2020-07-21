import { usePlugin } from "@nomiclabs/buidler/config";

usePlugin("@nomiclabs/buidler-waffle");

require("ts-node/register");
require("tsconfig-paths/register");

export default {
  networks: {
    buidlerevm: { allowUnlimitedContractSize: true },
    localhost: { url: "http://localhost:8545" },
    coverage: {
      url: "http://localhost:7546",
    },
  },
  solc: {
    version: "0.6.8",
    optimizer: {
      enabled: true,
      runs: 200,
    },
  },
  paths: { artifacts: "./build/contracts" },
};
