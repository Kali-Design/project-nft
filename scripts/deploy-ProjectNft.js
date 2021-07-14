const hre = require('hardhat');
const { deployed } = require('./deployed');

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');


  const [deployer] = await ethers.getSigners();
  console.log('Deploying contracts with the account:', deployer.address);

  // We get the contract to deploy
  const ProjectNft = await hre.ethers.getContractFactory('ProjectNft');
  const ProjectNft = await ProjectNft.deploy('Hello, Hardhat!');

  
  await ProjectNft.deployed();

  // Create/update deployed.json and print usefull information on the console.
  await deployed('ProjectNft', hre.network.name, ProjectNft.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
