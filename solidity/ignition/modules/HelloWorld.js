const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
module.exports = buildModule("HelloWorldModule", (m) => {
  const object = m.contract("HelloWorld", []);
  console.log(object.greet);
  return { object };
});
