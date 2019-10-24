import React from 'react';
import { Text, StyleSheet, View, Image } from 'react-native';



export const OnboardImage = ({ step }) => {

  return (
    <View style={styles.location}>
      <View style={styles.containerImage}>
        {step == 1 ? (
          <Image
            style={styles.locationImage}
            source={require('../../assets/onboarding1.png')}
          />
        ): (step == 2) ? (
          <Image
            style={styles.locationImage}
            source={require('../../assets/onboarding2.png')}
          />
        ):
        (
          <Image
            style={styles.locationImage}
            source={require('../../assets/onboarding3.png')}
          />
        )}
      </View>
      <View style={styles.containerPagination}>
        {step == 1 ? (
          <Image
            style={styles.locationPagination}
            source={require('../../assets/pagination1.png')}
          />
        ): (step == 2) ? (
          <Image
            style={styles.locationPagination}
            source={require('../../assets/pagination2.png')}
          />
        ):
        (
          <Image
            style={styles.locationPagination}
            source={require('../../assets/pagination3.png')}
          />
        )}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  location: {

  },
  containerImage: {

  },
  containerPagination: {
    alignItems: 'center',
  },
  locationImage: {
    width: null,
    height: 400
  },
  locationPagination: {
    width: 30,
    resizeMode: 'contain',
    height:30
  }
});
