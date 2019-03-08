import React, {Component} from 'react';
import {Image} from 'react-native'
import {Easing, StyleSheet, Text, View, UIManager, findNodeHandle, Dimensions, Animated} from 'react-native';
import ARScene from './ARView.js';
var icon = require('./icon.png');

type Props = {};
var {height, width} = Dimensions.get('window');
export default class App extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {home: 0,
                  introAnim: new Animated.Value(0),
                  loadingAnimShift: new Animated.Value(1),
                  loadingAnimScale: new Animated.Value(0),
                  loadingIconScale: new Animated.Value(0),

                }
}
handleClick = () => {
  this.setState({home: 1})
}
componentDidMount() {
  this.nodeHandle = findNodeHandle(this.ref);
  Animated.timing(
      this.state.introAnim,           
      {
        toValue: 1,                  
        duration: 350,   
        delay: 5000          
      }
  ).start();
  Animated.timing(
    this.state.loadingAnimShift,           
    {
      toValue: 0,                  
      duration: 4700,   
      delay: 0,
      easing: Easing.linear          
    }
).start();
Animated.timing(
  this.state.loadingAnimScale,           
  {
    toValue: 1,                  
    duration: 4700,   
    delay: 0,
    easing: Easing.linear                  
  }
).start();
Animated.timing(
  this.state.loadingIconScale,           
  {
    toValue: 1,                  
    duration: 1000,   
    delay: 4000,
    easing: Easing.elastic(1)                
  }
).start();
}


  render() {
        return (
          <Animated.View style={{
            backgroundColor: '#008fbe',
            transform: [{
              translateX: this.state.introAnim.interpolate({
                inputRange: [0, 1],
                outputRange: [0, -width]})
            }]
          }}>
            <View style = {{flex: 1, flexDirection: 'row', width: width*2, height: height}}>
                <View style = {{backgroundColor: '#ffffff', zIndex: 1,width: width, height: height, flex: 1, flexDirection: 'column', alignContent: 'center', justifyContent: 'center'}} >
                  <Animated.View style = {{
                    opacity: this.state.loadingIconScale.interpolate({
                      inputRange: [0, 1],
                      outputRange: [0, 1]
                    }),
                    transform: [{
                      scale: this.state.loadingIconScale.interpolate({
                      inputRange: [0, 1],
                      outputRange: [.75, 1]},
                      ) 
                    },
                  ]
                  }}>
                    <View style = {{shadowColor: '#000000b0', shadowRadius: 5, shadowOpacity: 1, shadowOffset: {width: 0, height: 1}, position: 'relative', center: height/2 - height * .15, left: width/2 - width * .15 }}>
                      <Image source = {icon} style = {{borderRadius: 50, width: width * .3, height: width * .3}}></Image>
                    </View>
                  </Animated.View>
                  <View style = {{width: width * .3, height: 10,backgroundColor: '#0000001a',borderRadius: 5, position: 'absolute', top: height/2 + height * .2, left: width/2 - width * .15}}></View>
                  <Animated.View style ={{width: 20, height: 20, position: 'absolute', top: height/2 + height * .2, left: width/2 - (width * .15)}}>
                    <Animated.View style = {{width: width * .3, height: 10, 
                                           backgroundColor: '#008fbe',borderRadius: 5, 
                                            width: this.state.loadingAnimScale.interpolate({
                                              inputRange: [0, 1],
                                              outputRange: [0, width * .3]})}}>
                    </Animated.View>
                  </Animated.View>
                </View>
              <ARScene/>  
            </View>
          </Animated.View>  
        );
    }
}


const styles = StyleSheet.create({
  root:{
    flex:1,
    justifyContent: 'space-evenly',
    alignItems: 'flex-start',
    flexDirection: 'row',
    position: 'absolute',
    top: "25%"
  },
  welcome4: {
    color: "#FFFFFF", 
    fontWeight: "600", 
    fontSize: 80, 
    width: '100%',
    fontFamily: 'Product Sans',
    fontStyle: 'italic',
    textAlign: 'center',
    position: 'absolute',
    top: height*.285
  },
  image: {
    position: "absolute",
    resizeMode: 'stretch',
    height: '100%',
    zIndex: -1,
  },
  button_bg: {
    alignSelf: 'center',
    position: 'absolute',
    bottom: '10%',
    paddingBottom: '10%'
  },
});


/*
<Image source={require('./cole.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./artem.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./micheal.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./isaac.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./jake.png')} style={{width: 100, height: 70, margin: 5}}/>
            */