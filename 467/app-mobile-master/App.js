import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { createAppContainer } from 'react-navigation';
import { createStackNavigator } from 'react-navigation-stack';
import HomeScreen from './src/screens/HomeScreen/HomeScreen';
import DetailsScreen from './src/screens/DetailsScreen/DetailsScreen';
import OnboardingScreen from './src/screens/OnboardingScreen/OnboardingScreen';
import OnboardingScreenOne from './src/screens/OnboardingScreen/steps/OnboardingScreenOne';
import OnboardingScreenTwo from './src/screens/OnboardingScreen/steps/OnboardingScreenTwo';
import OnboardingScreenThree from './src/screens/OnboardingScreen/steps/OnboardingScreenThree';

const RootStack = createStackNavigator(
  {
    Home: HomeScreen,
    Details: DetailsScreen,
    Onboarding: OnboardingScreen,
    OnboardingStep1: OnboardingScreenOne,
    OnboardingStep2: OnboardingScreenTwo,
    OnboardingStep3: OnboardingScreenThree,
  },
  {
    initialRouteName: 'OnboardingStep1',
    headerMode: 'none',
  }
);

const AppContainer = createAppContainer(RootStack);

export default class App extends React.Component {
  render() {
    return <AppContainer />;
  }
}
