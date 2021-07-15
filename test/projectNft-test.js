const { expect } = require('chai');

describe('ProjectNft', function () {
  it('Should return the new nft once it\'s changed', async function () {
    // eslint-disable-next-line no-undef
    const ProjectNft = await ethers.getContractFactory('ProjectNft');
    const projectnft = await ProjectNft.deploy('Hello, world!');
    await projectnft.deployed();

    expect(await projectnft.nft()).to.equal('Hello, world!');

    const setNftingTx = await projectnft.setNft('Hola, mundo!');

    // wait until the transaction is mined
    await setNftingTx.wait();

    expect(await projectnft.nft()).to.equal('Hola, mundo!');
  });
});
