import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View, Picker, Animated } from 'react-native'
import { Dropdown } from 'react-native-material-dropdown';
import {Tile} from 'react-native-elements'
import ARScene from './ARView.js';
import { Button }  from 'react-native-elements';

type Props = {};

export default class MoveControls extends Component<Props> {
    constructor(props) {
      super(props);
      this.state = {fadeAnim: new Animated.Value(0),};
    }
    componentDidMount() {
        Animated.timing(                  // Animate over time
          this.state.fadeAnim,            // The animated value to drive
          {
            toValue: 1,                   // Animate to opacity: 1 (opaque)
            duration: 10000,              // Make it take a while
          }
        ).start();                        // Starts the animation
      }
    render(){
        let { fadeAnim } = this.state;

        return(
            <Animated.View                 // Special animatable View</Animated.View>
        style={{
          ...this.props.style,
          opacity: fadeAnim,         // Bind opacity to animated value
        }}
      >
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
            buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 60, height: 55}}
            containerStyle={{marginVertical: -5, height: 40, width: 55, alignSelf: 'center'}}
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
            buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 60, height: 55}}
            containerStyle={{marginVertical: 1, height: 40, width: 55, alignSelf: 'center'}}
            onPress = {this.handleControl.bind(this, "left")}                /> 
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
            buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 60, height: 55}}
            containerStyle={{marginVertical: 1, height: 40, width: 55, alignSelf: 'center'}}
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
            buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 60, height: 55}}
            containerStyle={{marginBottom:-5, marginTop: 10, height: 40, width: 55, alignSelf: 'center'}}
            onPress = {this.handleControl.bind(this, "down")}                /> 
            
</View>

          </View>
          </Animated.View>
        );
    }
    handleControl(e) {
        console.log('Clicked', e);
        buttonPressed = e;
        this.adjustObject();
        if (e == "confirmPlacement") {
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