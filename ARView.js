import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Button, UIManager, findNodeHandle, requireNativeComponent} from 'react-native';

type Props = {};

export default class ARScene extends Component<Props> {

  constructor(props) {
      super(props);
  }

  render() { 
    return(
      <View style ={{flex: 1, flexDirection: 'column'}}>
      <ARView style=
            {{height: 1, width: 375}}
            ref={ref => (this.ref = ref)}
          />
          <View style = {styles.place_holder}></View>          
          <Button style={styles.addObject} title='Add Object' onPress={this.update}></Button>
      </View>
    );
  }

  update = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.ref),
      UIManager[ARView].Commands.addObject,
      [42]
    );
  };
}

const ARView = requireNativeComponent("ARView")
const styles = StyleSheet.create({
  addObject: {
    width: 375,
    fontSize: 20,
    textAlign: 'center',
    color: '#333333',
    alignSelf: 'stretch'
  },
  place_holder: {
    backgroundColor: '#000000',
    height: 800,
    alignSelf: 'stretch',
  }
});

/*

          */
