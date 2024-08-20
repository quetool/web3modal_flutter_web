import { WagmiCore, Chains, Web3modal, Connectors } from "https://cdn.jsdelivr.net/npm/cdn-wagmi@3.0.0/dist/cdn-wagmi.js"

const { createWeb3Modal, defaultWagmiConfig } = Web3modal
const { mainnet, sepolia } = Chains
const { reconnect, getAccount, getChainId, getToken, signMessage } = WagmiCore

const projectId = '.....'

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

window.getToken = async function (address, chainId) {
  if (!address) {
    console.error("No token address provided");
    return null;
  }
  try {
    const token = await getToken(config, {
      address: address,
      chainId: chainId,
    });
    return token;
  } catch (error) {
    console.error("Error fetching token info:", error);
    return null;
  }
}

window.signMessage = async function (message, accountAddress) {
  if (!message) {
    console.error("No message provided");
    return null;
  }
  if (!accountAddress || !/^0x[a-fA-F0-9]{40}$/.test(accountAddress)) {
    console.error("Invalid account address provided");
    return null;
  }
  try {
    const signedMessage = await signMessage(config, {
      account: accountAddress,
      message: message,
    });

    return signedMessage;
  } catch (error) {
    console.error("Error message sign:", error);
    return null;
  }
}
