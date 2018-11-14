/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Button, requireNativeComponent} from 'react-native';


type Props = {};

export default class App extends Component<Props> {
  
  switchAR() {
    this.setState({inARview: 1});
  }

  constructor(props) {
    super(props);
    this.state = {inARview: 0};
    this.switchAR = this.switchAR.bind(this);
  }

  render() {
    if (this.state.inARview == 1) {
      console.log(ARView)
      return (<ARView style={{height: 667, width: 375}} />) 
    }

    return (

      <View style={styles.container}>
        <Text style={styles.meme}>s p a c e b o i s</Text>
        <Button style={styles.instructions} title='Click here for MAGICAL AUGMENTED REALITY' onPress={this.switchAR}></Button>
      </View>

    );
  }
}

const ARView = requireNativeComponent("ARView")

const styles = StyleSheet.create({
  meme: {
    fontSize: 50,
    justifyContent: 'center',
    color: '#000000',
    margin: 10,
  },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
