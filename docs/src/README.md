# Smart Deployer

Smart Deployer is a universal solution for organizing and managing paid smart contract deployments.

📚 [Contracts documentation](https://aleksandrwhite-t.github.io/smart-deployer/) (generated with `forge doc`)  
🎓 [Solidity Bootcamp](https://bootcamp.solidity.university)

🧾 Every contract in this repository is fully documented using NatSpec — including deployment instructions, configuration details, and extensibility tips. Developed by Solidity University, following best practices and released under the MIT license, allows developers to:

- Deploy your own `DeployManager.sol`
- Create & connect utility contracts using [template](https://github.com/SolidityUniversity/smart-deployer/blob/main/src/UtilityContract/AbstractUtilityContract.sol)
- Monetize the deployment of utility contracts
- Enable\disable contracts, fees any time

![Smart deployer diagram](./docs/smart-deployer.png) 

> 💡 We are building it as part of the [Solidity University Bootcamp](https://bootcamp.solidity.university) program. Learn Solidity with us at [Solidity University](https://solidity.university)!


---

## 🚀 Getting Started

To start working with this repository, clone it and install all necessary dependencies.

```bash
git clone https://github.com/solidity-university/smart-deployer.git
cd smart-deployer
yarn install
```

> ✅ Make sure you have [Foundry](https://book.getfoundry.sh/getting-started/installation) installed globally before continuing:

---

## 🛠 Build the Project

Compile the contracts using:

```bash
forge build
```

You can run 🧪 tests using:

```bash
forge test
```

## 📚 Generate Documentation

To generate contract documentation:

```bash
forge doc --build --out docs
```

The generated site is written to `docs/book/`. After you enable **GitHub Pages** (Source: **GitHub Actions**) in the repository settings, pushes to `main` or `smart-deployer` deploy the book to [https://aleksandrwhite-t.github.io/smart-deployer/](https://aleksandrwhite-t.github.io/smart-deployer/). Do not add a `.gitignore` inside `docs/` that hides the mdBook sources.

**Note:** The user site `https://USERNAME.github.io/` without a path applies only to a repository named `USERNAME.github.io`. This project uses **project Pages** at the URL above.

---

Feel free to contribute or open issues to improve the project 💡
