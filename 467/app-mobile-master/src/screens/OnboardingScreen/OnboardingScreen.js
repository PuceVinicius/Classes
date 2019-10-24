import React, { Component } from 'react';
import { View, Text, Button } from 'react-native';

class OnboardingScreen extends Component {
  componentDidMount() {}
  render() {
    return (
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
        <Text>OnboardingScreensss</Text>
        <Button
          title="Onboarding"
          onPress={() => this.props.navigation.navigate('OnboardingStep1')}
        />
      </View>
    )
  }
}
export default OnboardingScreen;
