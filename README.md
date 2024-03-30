# BlueDine

## Overview

Duke University's diverse community has a common challenge: finding satisfying dining options that fit various dietary preferences, budgets, and nutritional goals. Blue Dine is designed to be your personal dining companion at Duke, offering a smart, all-in-one solution. Using AI, it customizes dining options to your needs, tracks spending, and manages caloric intake, all while providing a seamless user experience.

## Features

- **AI-Powered Search**: Utilizing Pinecone's vector database for natural language queries, delivering relevant dining options.
- **Comprehensive Backend Services**: Managed efficiently with PocketBase and FastAPI for real-time data handling.
- **Duke's Dining Info**: Access through Duke University's public API, ensuring up-to-date and accurate restaurant information.
- **Interactive Chatbot**: Powered by Gemini, assisting users with navigation, recommendations, and queries.
- **Personalized Finance Tracking**: Developed with a hackathon-provided dataset, allowing users to monitor dining expenses and budget effectively.
- **Nutritional Information**: Calorie counts and nutritional info for over 300+ items, aiding in health-conscious dining decisions.

## How It's Built

Blue Dine leverages the Flutter framework for its cross-platform capabilities, combined with the power of Pinecone for AI-search, PocketBase with FastAPI for backend services, and an innovative chatbot experience through Gemini. It integrates with Duke's public API for real-time dining data and utilizes a comprehensive dataset of Duke's dining options, meticulously compiled and enriched with essential details.

## App Demo
[Watch Demo here](https://youtu.be/x7aw_Tkn6YM)


## Installation and Running Blue Dine

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- An IDE (Preferably [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/))

### Installing

```bash
git clone https://github.com/rootsec1/BlueDine
cd BlueDine
flutter pub get
flutter run
```

## Challenges

Integrating diverse APIs and ensuring the relevance of search results was our primary challenge. Additionally, developing a user-friendly finance feature and creating a detailed dataset from scratch tested our skills and resilience.

## Accomplishments

We're proud of Blue Dine's comprehensive feature set, especially our tailored AI search and personalized finance tracking. Our biggest achievement lies in the seamless integration of these technologies to enhance Duke's dining experience.

## Lessons Learned

This project broadened our understanding of vector databases and AI, honed our Flutter development skills, and underscored the importance of a user-centric design philosophy.

## What's Next

We plan to expand our dining locations database, refine the AI search algorithm, and further develop our finance management features. Continuous user feedback will guide our journey towards making Blue Dine even more indispensable to the Duke community.

## How to Contribute

We welcome contributions from the Duke community and beyond. Whether it's suggesting new features, improving existing ones, or reporting bugs, your feedback is invaluable.

## License

This project is licensed under the [MIT License](LICENSE.md).

