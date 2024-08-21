import { WagmiCore, Chains, Web3modal } from "https://cdn.jsdelivr.net/npm/cdn-wagmi@3.0.0/dist/cdn-wagmi.js"

const { createWeb3Modal, defaultWagmiConfig } = Web3modal
const { mainnet, sepolia } = Chains

const { reconnect, getAccount, getChainId, getToken, signMessage, writeContract, getBalance, } = WagmiCore

const projectId = '....'

const metadata = {
  name: 'Web3Modal',
  description: 'Web3Modal Example',
  url: 'https://web3modal.com', // url must match your domain & subdomain
  icons: ['https://avatars.githubusercontent.com/u/37784886']
}

const config = defaultWagmiConfig({
  chains: [mainnet, sepolia],
  projectId,
  metadata,
})
reconnect(config)

const modal = createWeb3Modal({
  wagmiConfig: config,
  projectId,
  enableAnalytics: true, // Optional - defaults to your Cloud configuration
  enableOnramp: true // Optional - false as default
})

// Expose functions to the global `window` object
window.openModal = function () {
  return modal.open()
}

window.closeModal = function () {
  return modal.close()
}

window.getAccount = function () {
  const account = getAccount(config);
  return account;
}

window.getChainId = function () {
  const chainId = getChainId(config);
  return chainId;
}


window.getBalance = async function (getBalanceParameters) {
  if (!getBalanceParameters.address || !/^0x[a-fA-F0-9]{40}$/.test(getBalanceParameters.address)) {
    console.error("Invalid address provided");
    return null;
  }

  try {
    return await getBalance(config, getBalanceParameters);
  } catch (error) {
    console.error("Error fetching balance:", error);
    return null;
  }
}

window.getToken = async function (getTokenParameters) {
  if (!getTokenParameters.address) {
    console.error("No token address provided");
    return null;
  }
  try {
    return await getToken(config, getTokenParameters);
  } catch (error) {
    console.error("Error fetching token info:", error);
    return null;
  }
}

window.signMessage = async function (signMessageParameters) {
  if (!signMessageParameters.message) {
    console.error("No message provided");
    return null;
  }
  if (!signMessageParameters.account || !/^0x[a-fA-F0-9]{40}$/.test(signMessageParameters.account)) {
    console.error("Invalid account address provided");
    return null;
  }
  try {
    return await signMessage(config, signMessageParameters);
  } catch (error) {
    console.error("Error message sign:", error);
    return null;
  }
}

window.writeContract = async function (writeContractParameters) {
  try {
    return await writeContract(config, writeContractParameters)
  } catch (error) {
    console.error("Error writeContract:", error);
    return null;
  }
}
