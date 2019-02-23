import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, Animated, requireNativeComponent, Dimensions} from 'react-native';
import { Button }  from 'react-native-elements';
import StyleView from './StyleView';
import MoveControls from './MoveControls.js'
import Icon from 'react-native-vector-icons/FontAwesome';
import AnimateView from './AnimateView.js'
import FurnitureAnimator from './FurnitureAnimator';
type Props = {};
var buttonPressed = "";
var objectSelected = false;
var {height, width} = Dimensions.get('window');


export default class ARScene extends Component<Props> {

    constructor(props) {
        super(props);
        this.state = {AR: 1,
                      objectSelected: false,
                      checkScale: new Animated.Value(1)};
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
                    }}>
                        <Animated.View style={{position: 'absolute', bottom: height*.12, left: 0, width: width, opacity: this.state.checkScale
                            
                              }}>
                            <Button
                                title={""}
                                icon={
                                  <Icon
                                    name="check-circle-o"
                                    size={height * .075}
                                    color="white"
                                  />
                                }
                                ViewComponent={require('react-native-linear-gradient').default}
                                titleStyle={{fontWeight: 'bold', fontSize: 20, fontFamily: 'Product Sans'}}
                                linearGradientProps={{
                                    colors: ['#000000', '#000000'],
                                    start: {x: 0, y: 0},
                                    end: {x: 0.5, y: 0},
                                }}
                                buttonStyle={{borderWidth: 0, borderColor: 'transparent', 
                                borderRadius: height, height: height* .075}}
                                containerStyle={{ height: height, width: height*.075, alignSelf: 'center'}}
                                onPress={this.update}
                            />
                        </Animated.View>
                    </View>
                    <View style = {{position: 'absolute', top: 0, left: 0}}>
                            <Button
                            title={'Send Map'}
                                ViewComponent={require('react-native-linear-gradient').default}
                                titleStyle={{fontWeight: 'bold', fontSize: 20, fontFamily: 'Product Sans'}}
                                linearGradientProps={{
                                    colors: ['#000000', '#000000'],
                                    start: {x: 0, y: 0},
                                    end: {x: 0.5, y: 0},
                                }}
                                buttonStyle={{borderWidth: 0, borderColor: 'transparent', 
                                borderRadius: height, height: height* .075}}
                                containerStyle={{ height: height, width: height*.075, alignSelf: 'center'}}
                                onPress={this.handleControl.bind(this, "sendMap")}                            />
                    </View>
                    <View style = {{position: 'absolute', backgroundColor: "#00000000", height: '100%', zIndex: 25, bottom: -height}}>
                  <FurnitureAnimator onPress={this.selectFurniture}/>
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
        Animated.timing(
            this.state.confirmScale,            // The animated value to drive
            {
              toValue: 0,                   // Animate to opacity: 1 (opaque)
              duration: 300,              // Make it take a while
            }
          ).start();
          Animated.timing(
          this.state.checkScale,            // The animated value to drive
            {
              toValue: 1,                   // Animate to opacity: 1 (opaque)
              duration: 300,              // Make it take a while
            }
          ).start();
        console.log('handleControl')
        console.log('Clicked', e);
        buttonPressed = e;
        this.adjustObject();
        if (e == "confirmPlacement" || e == "deleteObject") {
            objectSelected = false;
            this.forceUpdate();
        }
    };
    test = () => {
      this.setState({objectSelected: !this.state.objectSelected})      
    };
    update = () => {
        console.log('update')
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this.ref),
            UIManager[ARView].Commands.placeObject,[]
        );
        Animated.timing(
          this.state.checkScale,            // The animated value to drive
          {
            toValue: 1,                   // Animate to opacity: 1 (opaque)
            duration: 300,              // Make it take a while
          }
      ).start();
    };

    choose = () => {
        this.setState({AR: 0});
    };

    adjustObject = () => {
        console.log("adjustObject")
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this.ref),
            UIManager[ARView].Commands.adjustObject,
            [buttonPressed]
        );
    };

    sendMap = () => {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this.ref),
            UIManager[ARView].Commands.sendMap,[]
        );
    };

    selectFurniture = e => {
        console.log("HELLO"+e)
      var obj
      if(e == 'couch9'){
        obj = 'couch_1'
      }
      else if(e == 'couch5'){
          obj = 'couch_2'
      }
      else if(e == 'couch11'){
          obj = 'couch_3'
      }
      else if(e == 'chair3'){
        obj = 'chair_1'
      }
      else if(e == 'chair1'){
        obj = 'chair_2'
      }
      else if(e == 'table6'){
        obj = 'table_1'
      }
      else if(e == 'cabinet3'){
        obj = 'wardrobe'
      }
      else if(e == 'cabinet9'){
        obj = 'coffee_table'
      }
      else{
          obj = 'couch_1'
      }
      console.log("STRINGSEARH "+obj)
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.ref),
        UIManager[ARView].Commands.setObjectToPlace,
        [obj]
    );
    }


    selectObject = e => {
        console.log(e);
        objectSelected = true;
        Animated.timing(
            this.state.checkScale,            // The animated value to drive
            {
              toValue: 0,                   // Animate to opacity: 1 (opaque)
              duration: 300,              // Make it take a while
            }
          ).start();
          placing = false;
          Animated.timing(
            this.state.confirmScale,            // The animated value to drive
            {
              toValue: 1,                   // Animate to opacity: 1 (opaque)
              duration: 300,              // Make it take a while
            }
          ).start();
        
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
