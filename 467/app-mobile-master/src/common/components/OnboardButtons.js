import React from 'react';
import { Text, StyleSheet, View, Image } from 'react-native';



export const OnboardButtons = ({ props, step }) => {
  return (
    <View style={styles.location}>
            { step != 3 ?
              (
                <View style={styles.containerButton}>
                  <Text style={styles.buttonSkip}
                    onPress={() => props.navigation.goBack()}>
                    Skip
                  </Text>
                  <Text style={styles.buttonNext}
                    onPress={() => props.navigation.navigate(`OnboardingStep${parseInt(step)+1}`)}>
                    Next
                  </Text>
                </View>
              ):
              (
                <View style={styles.container}>
                  <View style={styles.containerThree}>
                    <Text style={styles.button}
                      onPress={() => props.navigation.navigate('Onboarding')}>
                    LOGIN</Text>
                    </View>
                    <View style={styles.containerAlready}>
                      <Text style={styles.terms}
                        onPress={() => props.navigation.navigate('Onboarding')}>
                        Terms & Condition
                      </Text>
                  </View>
                </View>
              )
            }
    </View>
  );
};

const styles = StyleSheet.create({
  location: {
    height: 50
  },
  containerButton: {
    flex: 2,
    flexDirection: 'row',
    justifyContent: 'space-evenly'
  },
  container: {
    flex: 2,
    flexDirection: 'column',
    justifyContent: 'space-between',
    height: 50,
    alignItems: 'center',
  },
  buttonNext: {
    backgroundColor: '#3AD29F',
    borderRadius: 25,
    overflow: 'hidden',
    fontFamily: 'HelveticaNeue-Medium',
    fontSize: 14,
    color: '#FFFFFF',
    letterSpacing: 1,
    textAlign: 'center',
    lineHeight: 45,
    width: 100,
    height: 50
  },
  buttonSkip: {
    backgroundColor: '#D0D0D0',
    borderRadius: 25,
    overflow: 'hidden',
    fontFamily: 'HelveticaNeue-Medium',
    fontSize: 14,
    color: '#FFFFFF',
    letterSpacing: 1,
    textAlign: 'center',
    lineHeight: 45,
    width: 100,
    height: 50,
    letterSpacing: 0,
    textAlign: 'center'
  },
  buttonAlready: {
    opacity: 0.45,
    fontFamily: 'HelveticaNeue-Light',
    fontSize: 12,
    color: '#3E4A59',
    letterSpacing: 0,
    textAlign: 'center',
    lineHeight: 14
  },
  buttonLogIn: {
    fontFamily: 'HelveticaNeue-Light',
    fontSize: 12,
    fontWeight: 'bold',
    color: '#3E4A59',
    letterSpacing: 0,
    textAlign: 'center',
    lineHeight: 14
  },
  containerAlready: {
    paddingTop:'0%',
    height:40
  },
  button: {
    backgroundColor: '#3AD29F',
    borderRadius: 6,
    overflow: 'hidden',
    fontFamily: 'HelveticaNeue-Medium',
    fontSize: 14,
    color: '#FFFFFF',
    letterSpacing: 1,
    textAlign: 'center',
    lineHeight: 45,
    width: 315,
    height: 50
  },
  terms: {
    paddingTop: 15,
    opacity: 0.45,
    fontFamily: 'HelveticaNeue-Light',
    fontSize: 12,
    color: '#3E4A59',
    letterSpacing: 0,
    textAlign: 'center',
    lineHeight: 14
  }
});
