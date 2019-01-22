import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, requireNativeComponent} from 'react-native';
import { Button }  from 'react-native-elements';
import Furniture from './Furniture';
import StyleView from './StyleView';

type Props = {};

export default class ARScene extends Component<Props> {

  constructor(props) {
      super(props);
      this.state = {AR: 1};
  }

  render() {
      if (this.state.AR == 1) {
          return(
              <View>
                  <View style = {{width: '100%'}}>
                    <ARView style = {{height: '100%', width: '100%', backgroundColor: '#000000'}}
                            ref = {ref => (this.ref = ref)}
                    />
                  </View>

                  <View style = {{width: '100%', flex: 1, flexDirection: 'row', justifyContent: 'space-evenly',  zIndex: 2, position: 'absolute', bottom: '4%'}}>
                      <Button
                          title={"place"}
                          ViewComponent={require('react-native-linear-gradient').default}
                          titleStyle={{fontWeight: 'bold', fontSize: 12}}
                          linearGradientProps={{
                              colors: ['#3a43ba', '#01458e'],
                              start: {x:0, y:0},
                              end: {x:0.5, y:0},
                          }}
                          buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                          containerStyle={{marginVertical: 10, height: 40, width: 65, alignSelf: 'center'}}
                          onPress = {this.update}
                      />

                      <Button
                          title={"new"}
                          ViewComponent={require('react-native-linear-gradient').default}
                          titleStyle={{fontWeight: 'bold', fontSize: 12}}
                          linearGradientProps={{
                              colors: ["#3bba49", "#01912a"],
                              start: {x:0, y:0},
                              end: {x:.5, y:0},
                          }}
                          buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                          containerStyle={{marginVertical: 10, height: 40, width: 45, alignSelf: 'center'}}
                          onPress = {this.choose}
                      />
                   </View>

              </View>
          );
      } else {
          if (this.props.styled == 0) {
              return(<StyleView/>);
          } else {
              return(<Furniture src = 'https://www.ikea.com/us/en/images/products/karlstad-sofa-gray__0404895_PE577343_S4.JPG' name='couch'/>);
          }
      }
  }

  update = () => {
      UIManager.dispatchViewManagerCommand(
          findNodeHandle(this.ref),
          UIManager[ARView].Commands.enterPlacementMode,
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
