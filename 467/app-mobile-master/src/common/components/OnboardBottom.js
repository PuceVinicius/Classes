import React from 'react';
import { Text, StyleSheet, View, Image } from 'react-native';



export const OnboardBottom = ({ props, step }) => {

  return (
    <View style={styles.location}>

    {step != 3 ?
    (
      <View style={styles.location}>
        <Text style={styles.buttonAlready}
          onPress={() => props.navigation.navigate('Home')}>
          Already have an account?
          <Text style={styles.buttonLogIn}> Log in </Text>
        </Text>
      </View>
    ):
    (
      <View style={styles.location}>
      </View>
    )
  }
  </View>
  );
};

const styles = StyleSheet.create({
  location: {
    height:30
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
  }
});
