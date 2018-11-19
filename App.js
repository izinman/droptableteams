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
          <ARView style=
            {{height: 607, width: 375}}
            ref={ref => (this.ref = ref)}
          />
          <Button style={styles.addObject} title='Add Object' onPress={this.update}></Button>
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
  addObject: {
    height: 60,
    width: 375,

    fontSize: 20,
    textAlign: 'center',
    color: '#333333',
  },
});
