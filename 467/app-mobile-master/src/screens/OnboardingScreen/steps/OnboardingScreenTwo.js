import React, { Component } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import { Header } from "../../../common/components/Header.js";
import { OnboardImage } from "../../../common/components/OnboardImage.js";
import { OnboardButtons } from "../../../common/components/OnboardButtons.js";
import { OnboardBottom } from "../../../common/components/OnboardBottom.js";

class OnboardingScreenTwo extends Component {
  componentDidMount() {}
  render() {
    return (
        <View style={styles.container}>
            <Header message={`Daily steps to your \nenlightment.`}/>
            <OnboardImage step='2'/>
            <OnboardButtons step= '2' props={this.props} />
            <OnboardBottom step= '2' props={this.props} />
        </View>
      )
    }
  }
  const styles = StyleSheet.create({
    container: {
      flex:1,
      flexDirection: 'column',
      justifyContent: 'space-evenly',
      height: "100%",
      paddingTop: 25,
    }
});
export default OnboardingScreenTwo;
