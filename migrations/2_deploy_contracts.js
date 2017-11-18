var Polls = artifacts.require('./Polls.sol')

module.exports = function(deployer) {
    deployer.deploy(Polls)
}