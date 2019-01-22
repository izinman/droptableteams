import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, requireNativeComponent} from 'react-native';
import { Button }  from 'react-native-elements';
import Furniture from './Furniture';
import StyleView from './StyleView';

type Props = {};
var control = "";

export default class ARScene extends Component<Props> {

  constructor(props) {
      super(props);
      this.state = {AR: 1};
  }
  componentDidMount() {
    this.nodeHandle = findNodeHandle(this.ref);
}


  render() { 
    if(this.state.AR == 1)
    {
    return(
      <View >
      <View style = {{width: '100%'}}>
      <ARView style=
            {{height: '100%', width: '100%', backgroundColor: '#000000'}}
            ref={ref => (this.ref = ref)}
          />
          </View>
          <View style = {{width: '100%', flex: 1, flexDirection: 'column', justifyContent: 'space-evenly',  zIndex: 2, position: 'absolute', bottom: '5%'}}>
          
           <View style = {{width: '100%', flex: 1, flexDirection: 'row', justifyContent: 'space-evenly'}}>
           <View style={{flex:1, flexDirection: 'column', justifyContent: 'space-evenly', width: '50%'}}>
           <View style={{flex: 1, flexDirection: "row", justifyContent: 'space-evenly', width: 200}}>
           
           <Button     
                title={"Rotate"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#2962FF', '#2962FF'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 10, height: 40, width: 60, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "rotate")}
                /> 
            <Button     
                title={"Move"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#2962FF', '#2962FF'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 10, height: 40, width: 60, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "move")}
                /> 
          <Button     
                title={"Delete"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#D50000", "#D50000"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 10, height: 40, width: 55, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "delete")}                /> 
                </View>
           <View style={{flex: 1, flexDirection: "row", justifyContent: 'space-evenly', width: 200}}>
           
           <Button     
                title={"<"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#2962FF', '#2962FF'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 10, height: 40, width: 35, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "rotate-left")}                /> 
            <Button     
                title={">"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#2962FF', '#2962FF'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 10, height: 40, width: 35, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "rotate-right")}                /> 
          <Button     
                title={"Done"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#00C853", "#00C853"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 10, height: 40, width: 55, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "done")}                /> 
                </View>
                </View>
                <View style={{flex: 1, flexDirection: "column", justifyContent: 'space-evenly', width: '15%'}}>
                <Button     
                title={"^"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#616161", "#616161"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: -5, height: 40, width: 35, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "up")}                /> 
                <View style={{flex: 1, flexDirection: 'row', justifyContent: 'space-evenly'}}>
                <Button     
                title={"<"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#616161", "#616161"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 1, height: 40, width: 35, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "left")}                /> 
                <Button     
                title={">"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#616161", "#616161"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginVertical: 1, height: 40, width: 35, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "right")}                /> 
                </View>
                <View style ={{transform: [{ rotate: '180deg'}]}}>
                <Button     
                
                title={"^"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#616161", "#616161"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 35}}
                containerStyle={{marginBottom:-5, marginTop: 10, height: 40, width: 35, alignSelf: 'center'}}
                onPress = {this.handleControl.bind(this, "down")}                /> 
                
</View>
              </View>
           </View>
           <View style = {{width: '100%', flex: 1, flexDirection: 'row', justifyContent: 'space-evenly'}}>
          <Button     
                title={"Place"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#2962FF', '#2962FF'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                containerStyle={{marginVertical: 10, height: 40, width: 115, alignSelf: 'center'}}
                onPress = {this.update}
                /> 
          <Button     
                title={"New"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ["#00C853", "#00C853"],
                  start: {x:0, y:0},
                  end: {x:.5, y:0},
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                containerStyle={{marginVertical: 10, height: 40, width: 115, alignSelf: 'center'}}
                onPress = {this.choose}
                /> 
           </View>
           </View>
      </View>
    );
              }
              else{
                if(this.props.styled == 0){
                  return(
                    <StyleView/>
                  );
                }
                else{
                  return(
                    <StyleView/>
                  );
                }
                
              }
  }

  handleControl(e) {
    console.log('Clicked', e);
    control = e;
    this.control();
  }
  update = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.ref),
      UIManager[ARView].Commands.addObject,
      [24]
    );
  };
  choose = () => {
    this.setState({AR: 0});
  };

  control = () =>{
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.ref),
      UIManager[ARView].Commands.controlObject,
      [control]
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
    height: 650,
    alignSelf: 'stretch',
  }
});

/*

          */
