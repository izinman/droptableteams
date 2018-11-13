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
    this.setState({ARview: 1});
  }

  constructor(props) {
    super(props);
    this.state = {ARview: 0};
    this.switchAR = this.switchAR.bind(this);
  }

  render() {
    if (this.state.ARview == 1) return (

      <ARView style ={this.props.style} {...this.props} />

    )

    return (

      <View style={styles.container}>
        <Text style={styles.meme}>s p a c e b o i s</Text>
        <Button style={styles.instructions} title='Click here for MAGICAL AUGMENTED REALITY' onPress={this.switchAR}></Button>
      </View>

    );
  }
}

const ARView = requireNativeComponent('ARView', null)

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
