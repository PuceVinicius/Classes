import React, { Component } from 'react';
import { View, Text, Button } from 'react-native';

class HomeScreen extends Component {
  componentDidMount() {}
  componentDidUpdate() {}
  render() {
    return (
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
        <Text>H222ome Sdsadas2</Text>
        <Button
          title="Go back"
          onPress={() => this.props.navigation.goBack()}
        />
      </View>
    )
  }
}
export default HomeScreen;
