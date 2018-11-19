/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Button, UIManager, findNodeHandle, requireNativeComponent} from 'react-native';

type Props = {};

export default class App extends Component<Props> {

  constructor(props) {
      super(props);
  }

  render() { 
    return(
      <View>
          <ARView 
            styles = {ARViewStyle}
            ref = {ref => (this.ref = ref)}
          />
          <Button style={styles.addObjectButton} title='Add Object' onPress={this.placeObject}></Button>
      </View>
    );
  }

  placeObject = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.ref),
      UIManager[ARView].Commands.addObject,
      []
    );
  };
}

const ARView = requireNativeComponent("ARView")
const styles = StyleSheet.create({
  ARViewStyle: {
    height: Dimensions.get("window").height * 0.9,
    width: Dimensions.get("window").width,
  }

  addObjectButton: {
    height: Dimensions.get("window").height * 0.1,
    width: Dimensions.get("window").width,

    fontSize: 20,
    textAlign: 'center',
    color: '#333333',
  },
});
