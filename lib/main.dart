import 'dart:js_interop';
import 'package:flutter/material.dart';

@JS()
external JSWindow get window;

@JS()
extension type JSWindow(JSObject _) implements JSObject {
  external void openModal();
  external void closeModal();
  external Account getAccount();
  external int getChainId();
  external JSPromise<Token> getToken(JSString address, int chainId);
  external JSPromise<JSString> signMessage(
      JSString message, JSString accountAddress);
  external JSPromise<WriteContractReturnType> writeContract(
    JSString contractAddress,
    JSString contractABI,
    JSString functionName,
    JSAny args,
    JSNumber gas,
    JSNumber chainId,
  );
}

@JS()
extension type Account(JSObject _) implements JSObject {
  external String? get address;
  external String? get status;
  external Chain? get chain;
  external int? get chainId;
  external Connector? get connector;
  external bool? isConnecting;
  external bool? isReconnecting;
  external bool? isConnected;
  external bool? isDisconnected;
}

@JS()
extension type Connector(JSObject _) implements JSObject {
  external bool? multiInjectedProviderDiscovery;
  external bool? ssr;
  external bool? syncConnectedChain;
}

@JS()
extension type Chain(JSObject _) implements JSObject {
  external int? id;
  external String? name;
}

@JS()
extension type Token(JSObject _) implements JSObject {
  external String? address;
  external int? decimals;
  external String? name;
  external String? symbol;
}

@JS()
extension type WriteContractReturnType(JSObject _) implements JSObject {
  external String? hash;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var chainId = 0;
  Token? token;
  Account? account;
  String? signedMessage;
  String? hashApproval;
  final tokenAddressToSearch = '0xCBBd3374090113732393DAE1433Bc14E5233d5d7';
  final messageToSign = 'Hello World';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Web3Modal')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  openModal(); // Call the function to connect wallet
                },
                child: const Text('Connect Wallet'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    signedMessage = null;
                    account = getAccount();
                    chainId = getChainId();
                  });
                },
                child: const Text('Get Account info'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('account address: ${account?.address ?? 'unknown'}'),
              Text('account status:  ${account?.status ?? 'unknown'}'),
              Text('account chain ID: ${account?.chainId ?? 'unknown'}'),
              Text('Chain ID: $chainId'),
              ElevatedButton(
                onPressed: () async {
                  token = await getToken(
                      tokenAddressToSearch, account?.chainId ?? 0);
                  setState(() {});
                },
                child: Text(
                    'Get Token info ($tokenAddressToSearch / ${account?.chainId})'),
              ),
              if (token != null)
                Column(
                  children: [
                    Text('token address: ${token?.address}'),
                    Text('token name: ${token?.name}'),
                    Text('token decimals: ${token?.decimals}'),
                    Text('token symbol: ${token?.symbol}'),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  signedMessage = await signMessage(messageToSign);
                  setState(() {});
                },
                child: Text('Personal sign ($messageToSign)'),
              ),
              if (signedMessage != null)
                Column(
                  children: [
                    Text('message signed: $signedMessage'),
                  ],
                ),
              ElevatedButton(
                onPressed: () async {
                  await call(
                      '0xCBBd3374090113732393DAE1433Bc14E5233d5d7',
                      abiERC20,
                      'approve',
                      [
                        '0x08Bfc8BA9fD137Fb632F79548B150FE0Be493254',
                        100000000,
                      ],
                      chainId);

                  setState(() {});
                },
                child: const Text('Call approve'),
              ),
              if (hashApproval != null)
                Column(
                  children: [
                    Text('Hash approval: $hashApproval'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void openModal() {
    window.openModal();
  }

  void closeModal() {
    window.closeModal();
  }

  Account getAccount() {
    return window.getAccount();
  }

  int getChainId() {
    return window.getChainId();
  }

  Future<Token?> getToken(String address, int chainId) async {
    try {
      Token token = await window.getToken(address.toJS, chainId).toDart;
      return token;
    } catch (e) {
      print("Error fetching token: $e");
      return null;
    }
  }

  Future<String?> signMessage(String message) async {
    try {
      final account = getAccount();
      final accountAddress = account.address;

      if (accountAddress == null || accountAddress.isEmpty) {
        print("No valid account address found.");
        return null;
      }

      final signedMessage =
          await window.signMessage(message.toJS, accountAddress.toJS).toDart;
      return signedMessage.toString();
    } catch (e) {
      print("Error sign message: $e");
      return null;
    }
  }

  Future<String?> call(String contractAddress, String contractABI,
      String functionName, List<dynamic> args, int chainId) async {
    try {
      final result = await window
          .writeContract(contractAddress.toJS, contractABI.toJS,
              functionName.toJS, args.jsify()!, 1500000.toJS, chainId.toJS)
          .toDart;
      return result.hash;
    } catch (e) {
      print("Error call: $e");
      return null;
    }
  }
}

const abiERC20 = '''[
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "name_",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "symbol_",
          "type": "string"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "owner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "spender",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "value",
          "type": "uint256"
        }
      ],
      "name": "Approval",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "from",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "to",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "value",
          "type": "uint256"
        }
      ],
      "name": "Transfer",
      "type": "event"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "owner",
          "type": "address"
        },
        {
          "internalType": "address",
          "name": "spender",
          "type": "address"
        }
      ],
      "name": "allowance",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "spender",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "approve",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "account",
          "type": "address"
        }
      ],
      "name": "balanceOf",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "decimals",
      "outputs": [
        {
          "internalType": "uint8",
          "name": "",
          "type": "uint8"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "spender",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "subtractedValue",
          "type": "uint256"
        }
      ],
      "name": "decreaseAllowance",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "spender",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "addedValue",
          "type": "uint256"
        }
      ],
      "name": "increaseAllowance",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "name",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "symbol",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "totalSupply",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "to",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "transfer",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "from",
          "type": "address"
        },
        {
          "internalType": "address",
          "name": "to",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "transferFrom",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ] ''';
