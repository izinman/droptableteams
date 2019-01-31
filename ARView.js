import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, requireNativeComponent} from 'react-native';
import { Button }  from 'react-native-elements';
import StyleView from './StyleView';
import MoveControls from './MoveControls.js'
import AnimateView from './AnimateView.js'
import FurnitureAnimator from './FurnitureAnimator';
type Props = {};
var buttonPressed = "";
var objectSelected = false;

export default class ARScene extends Component<Props> {

    constructor(props) {
        super(props);
        this.state = {AR: 1,
                      objectSelected: false};
    }

    componentDidMount() {
        this.nodeHandle = findNodeHandle(this.ref);
    }

    render() {
        if (this.state.AR == 1) {
            return (
                <View style = {{width: '100%', height: '100%'}}>
                    <View style={{width: '100%'}}>
                        <ARView style={{height: '100%', width: '100%', backgroundColor: '#000000'}}
                            ref={ref => (this.ref = ref)}
                            onObjectSelect={this.selectObject}
                        />
                    </View>
                    <View style={{
                        width: '100%',
                        height: '100%',
                        flex: 1,
                        flexDirection: 'column',
                        justifyContent: 'space-evenly',
                        zIndex: 2,
                    }}>
                        {objectSelected &&
                        <View style={{height: '100%'}}>
                          <AnimateView>
                            <View style = {{position: 'absolute',  bottom: 1000, left: 50}}>
                              <Button
                                title={"Delete"}
                                ViewComponent={require('react-native-linear-gradient').default}
                                titleStyle={{fontWeight: 'bold', fontSize: 18, fontFamily: 'Product Sans'}}
                                linearGradientProps={{
                                  colors: ["#D50000", "#D50000"],
                                  start: {x: 0, y: 0},
                                  end: {x: .5, y: 0},
                                }}
                                buttonStyle={{
                                  borderWidth: 0,
                                  borderColor: 'transparent',
                                  borderRadius: 20,
                                  height: 65
                                }}
                                containerStyle={{
                                  marginVertical: 10,
                                  height: 40,
                                  width: 80,
                                  alignSelf: 'center'
                                }}
                                onPress={this.handleControl.bind(this, "deleteObject")}/>
                            </View>
                          </AnimateView>
                          <AnimateView >
                          <View style = {{position: 'absolute', bottom: 1000, right: 50}}>
                          <Button     
                            title={"Done"}
                            ViewComponent={require('react-native-linear-gradient').default}
                            titleStyle={{fontWeight: 'bold', fontSize: 18, fontFamily: 'Product Sans'}}
                            linearGradientProps={{
                              colors: ["#00C853", "#00C853"],
                              start: {x:0, y:0},
                              end: {x:.5, y:0},
                            }}
                            buttonStyle={{borderWidth: 0, 
                                          borderColor: 'transparent', 
                                          borderRadius: 20, 
                                          height: 65}}
                            containerStyle={{marginVertical: 10, 
                                             height: 40, 
                                             width: 80, 
                                             alignSelf: 'center'}}
                            onPress = {this.handleControl.bind(this, "confirmPlacement")}                /> 
                            </View>
                          </AnimateView>
                        <View style={{width: '100%', flex: 1, flexDirection: 'row', justifyContent: 'space-evenly', position: 'absolute', bottom: 250}}>
                            <View style={{
                                flex: 1,
                                flexDirection: 'column',
                                justifyContent: 'space-evenly',
                                width: '50%'
                            }}>
                            <AnimateView >
                              <View style={{flex: 1, flexDirection: "row", justifyContent: 'space-evenly', width: 400}}>
                                <Button     
                                  title={"<"}
                                  ViewComponent={require('react-native-linear-gradient').default}
                                  titleStyle={{fontWeight: 'bold', fontSize: 12}}
                                  linearGradientProps={{
                                    colors: ['#2962FF', '#2962FF'],
                                    start: {x:0, y:0},
                                    end: {x:0.5, y:0},
                                  }}
                                  buttonStyle={{borderWidth: 0, 
                                                borderColor: 'transparent', 
                                                borderRadius: 60, 
                                                height: 55}}
                                  containerStyle={{marginVertical: 10, 
                                                  height: 40, 
                                                  width: 55, 
                                                  alignSelf: 'center'}}
                                  onPress = {this.handleControl.bind(this, "rotateLeft")}                /> 
                                <Button
                                  title={"Rotate"}
                                  ViewComponent={require('react-native-linear-gradient').default}
                                  titleStyle={{fontWeight: 'bold', fontSize: 18, fontFamily: 'Product Sans'}}
                                  linearGradientProps={{
                                    colors: ['#2962FF', '#2962FF'],
                                    start: {x: 0, y: 0},
                                    end: {x: 0.5, y: 0},
                                  }}
                                  buttonStyle={{
                                    borderWidth: 0,
                                    borderColor: 'transparent',
                                    borderRadius: 20,
                                    height: 65
                                  }}
                                  containerStyle={{
                                    marginVertical: 10,
                                    height: 40,
                                    width: 80,
                                    alignSelf: 'center'
                                  }}
                                  onPress={this.handleControl.bind(this, "rotate")}
                                />
                              <Button     
                                  title={">"}
                                  ViewComponent={require('react-native-linear-gradient').default}
                                  titleStyle={{fontWeight: 'bold', fontSize: 12}}
                                  linearGradientProps={{
                                    colors: ['#2962FF', '#2962FF'],
                                    start: {x:0, y:0},
                                    end: {x:0.5, y:0},
                                  }}
                                  buttonStyle={{borderWidth: 0, 
                                                borderColor: 'transparent', 
                                                borderRadius: 60, 
                                                height: 55}}
                                  containerStyle={{marginVertical: 10, 
                                                  height: 40, 
                                                  width: 55,
                                                  alignSelf: 'center'}}
                                  onPress = {this.handleControl.bind(this, "rotateRight")}                /> 
                              </View>
                            </AnimateView>
                          </View>
                        </View>
                        <View style={{
                          flex: 1,
                          flexDirection: "column",
                          justifyContent: 'space-evenly',
                          position: 'absolute',
                          bottom: 150,
                          right: 0
                        }}>
                          <AnimateView >
                            <View style={{flex: 1, flexDirection: "column", justifyContent: 'space-evenly', width: 400, height: 250}}>
                              <Button     
                                title={"^"}
                                ViewComponent={require('react-native-linear-gradient').default}
                                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                                linearGradientProps={{
                                  colors: ["#616161", "#616161"],
                                  start: {x:0, y:0},
                                  end: {x:.5, y:0},
                                }}
                                buttonStyle={{borderWidth: 0, 
                                              borderColor: 'transparent', 
                                              borderRadius: 60, 
                                              height: 55}}
                                containerStyle={{marginVertical: -5, 
                                                 height: 40, 
                                                 width: 55, 
                                                 alignSelf: 'center'}}
                                onPress = {this.handleControl.bind(this, "moveForward")}/> 
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
                                  buttonStyle={{borderWidth: 0, 
                                                borderColor: 'transparent', 
                                                borderRadius: 60, 
                                                height: 55}}
                                  containerStyle={{marginVertical: 1, 
                                                   height: 40, 
                                                   width: 55, 
                                                   alignSelf: 'center'}}
                                  onPress = {this.handleControl.bind(this, "moveLeft")}/> 
                                  <Button
                                    title={"Move"}
                                    ViewComponent={require('react-native-linear-gradient').default}
                                    titleStyle={{fontWeight: 'bold', fontSize: 18, fontFamily: 'Product Sans'}}
                                    linearGradientProps={{
                                      colors: ['#2962FF', '#2962FF'],
                                      start: {x: 0, y: 0},
                                      end: {x: 0.5, y: 0},
                                    }}
                                    buttonStyle={{
                                      borderWidth: 0,
                                      borderColor: 'transparent',
                                      borderRadius: 20,
                                      height: 65
                                    }}
                                    containerStyle={{
                                      marginVertical: 10,
                                      height: 60,
                                      width: 80,
                                      alignSelf: 'center'
                                    }}
                                    onPress={this.handleControl.bind(this, "move")}
                                  />
                                <Button     
                                  title={">"}
                                  ViewComponent={require('react-native-linear-gradient').default}
                                  titleStyle={{fontWeight: 'bold', fontSize: 12}}
                                  linearGradientProps={{
                                    colors: ["#616161", "#616161"],
                                    start: {x:0, y:0},
                                    end: {x:.5, y:0},
                                  }}
                                  buttonStyle={{borderWidth: 0, 
                                                borderColor: 'transparent', 
                                                borderRadius: 60, 
                                                height: 55}}
                                  containerStyle={{marginVertical: 1, 
                                                   height: 40, 
                                                   width: 55, 
                                                   alignSelf: 'center'}}
                                  onPress = {this.handleControl.bind(this, "moveRight")}                /> 
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
                                    buttonStyle={{borderWidth: 0, 
                                                  borderColor: 'transparent', 
                                                  borderRadius: 60, 
                                                  height: 55}}
                                    containerStyle={{marginBottom:-5, 
                                                     marginTop: 10, 
                                                     height: 40, 
                                                     width: 55, 
                                                     alignSelf: 'center'}}
                                    onPress = {this.handleControl.bind(this, "moveBackward")}                /> 
                                </View>
                              </View>
                            </AnimateView>
                          </View>    
                        </View>
                        }
                        <View style={{width: '100%', flex: 1, flexDirection: 'row', justifyContent: 'space-evenly', position: 'absolute', bottom: 50}}>
                            <Button
                                title={"Place"}
                                ViewComponent={require('react-native-linear-gradient').default}
                                titleStyle={{fontWeight: 'bold', fontSize: 20, fontFamily: 'Product Sans'}}
                                linearGradientProps={{
                                    colors: ['#2962FF', '#2962FF'],
                                    start: {x: 0, y: 0},
                                    end: {x: 0.5, y: 0},
                                }}
                                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                                containerStyle={{marginVertical: 10, height: 40, width: '40%', alignSelf: 'center'}}
                                onPress={this.update}
                            />
                            <Button
                                title={"New"}
                                ViewComponent={require('react-native-linear-gradient').default}
                                titleStyle={{fontWeight: 'bold', fontSize: 20, fontFamily: 'Product Sans'}}
                                linearGradientProps={{
                                    colors: ["#00C853", "#00C853"],
                                    start: {x: 0, y: 0},
                                    end: {x: .5, y: 0},
                                }}
                                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                                containerStyle={{marginVertical: 10, height: 40, width: '40%', alignSelf: 'center'}}
                                onPress={this.choose}
                            />
                            
                        </View>
                    </View>
                    <View style = {{position: 'absolute', height: '100%', zIndex: 25, bottom: '-97.5%'}}>
                  <FurnitureAnimator/>
                  </View>
                </View>
                              
            );
        } else {
            if (this.props.styled == 0) {
                return (
                    <StyleView/>
                );
            } else {
                return (
                    <StyleView/>
                );
            }

        }
    }

    handleControl(e) {
        console.log('Clicked', e);
        buttonPressed = e;
        this.adjustObject();
        if (e == "confirmPlacement" || e == "deleteObject") {
            objectSelected = false;
            this.forceUpdate();
        }
    }
    test = () => {
      this.setState({objectSelected: !this.state.objectSelected})      
    };
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

    adjustObject = () => {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this.ref),
            UIManager[ARView].Commands.adjustObject,
            [buttonPressed]
        );
    };

    selectObject = e => {
        objectSelected = true;
        console.log("Set objectSelected: ", objectSelected);
        this.forceUpdate();
    }
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
  },
});
