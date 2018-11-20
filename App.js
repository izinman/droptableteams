/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Button, UIManager, findNodeHandle, Dimensions, requireNativeComponent} from 'react-native';

type Props = {};

export default class App extends Component<Props> {

  constructor(props) {
      super(props);
  }

  render() { 
    return(
      <View>
          <ARView 
            style={styles.ARViewStyle}
            ref={ref => (this.ref = ref)}
          />
          <Button 
            style={styles.addObjButton} 
            title='Add Object' 
            onPress={this.update}>
          </Button>
      </View>
    );
  }

  update = () => {
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
  },

  addObjButton: {
    height: Dimensions.get("window").height * 0.1,
    width: Dimensions.get("window").width,

    fontSize: 20,
    textAlign: 'center',
    color: '#333333',
  },
});
