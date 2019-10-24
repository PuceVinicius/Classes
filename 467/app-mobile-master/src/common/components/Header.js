import React from 'react';
import { Text, StyleSheet, View } from 'react-native';

export const Header = ({ message }) => {
  return (
    <View style={styles.location}>
      <Text style={styles.text}>{message}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  location: {

  },
  text: {
    paddingLeft: 20,
    fontFamily: 'HelveticaNeue',
    fontSize: 30,
    color: '#3AD29F',
    letterSpacing: 0
  }

});
