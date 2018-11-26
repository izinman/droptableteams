import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, requireNativeComponent} from 'react-native';
import { Button }  from 'react-native-elements';
import Furniture from './Furniture';

type Props = {};

export default class ARScene extends Component<Props> {

  constructor(props) {
      super(props);
      this.state = {AR: 1};
  }

  render() { 
    if(this.state.AR == 1)
    {
    return(
      <View style ={{flex: 1, flexDirection: 'column'}}>
      <ARView style=
            {{height: 1, width: 375}}
            ref={ref => (this.ref = ref)}
          />
          <View style = {styles.place_holder}></View>          
          <Button     
                title={"place object"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#0064e8', '#00ffed'],
                  start: [1, 0],
                  end: [0.2, 0],
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                containerStyle={{marginVertical: 10, height: 40, width: 300, alignSelf: 'center'}}
                onPress = {this.update}
                /> 
          <Button     
                title={"choose object"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#0064e8', '#00ffed'],
                  start: [1, 0],
                  end: [0.2, 0],
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                containerStyle={{marginVertical: 10, height: 40, width: 300, alignSelf: 'center'}}
                onPress = {this.choose}
                /> 
      </View>
    );
              }
              else{
                return(
                  <Furniture src = 'https://www.ikea.com/us/en/images/products/karlstad-sofa-gray__0404895_PE577343_S4.JPG' name='couch'/>
                );
              }
  }

  update = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.ref),
      UIManager[ARView].Commands.addObject,
      [42]
    );
  };
  choose = () => {
    this.setState({AR: 0});
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
    height: 650,
    alignSelf: 'stretch',
  }
});

/*

          */
