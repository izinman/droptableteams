import React, {Component} from 'react';
import {Image} from 'react-native'
import StyleView from './StyleView.js'
import { Button}  from 'react-native-elements';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, Dimensions, requireNativeComponent} from 'react-native';
import ARScene from './ARView.js';
import AnimateView from './AnimateView.js'

type Props = {};
var {height, width} = Dimensions.get('window');
export default class App extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {home: 0}
}
handleClick = () => {
  this.setState({home: 1})
}


  render() {
      if(this.state.home == 0){
        return (
          
          <View style={{width: '100%', justifyContent: 'center', alignSelf: 'center' }}>
            <View style = {{position: 'absolute', top: 0, left: 0, bottom: 0, right: 0, zIndex: 0, backgroundColor: "#000000", opacity: 0.55, height: '100%'}}></View>
             <Image source={require('./home.jpg')} style ={styles.image} blurRadius = {0}/>
             
          <View styles={styles.root} >
            <Text style ={styles.welcome4}>designAR </Text>
            
            <View style={{justifyContent:'center', alignContent: 'center',height: height}}>
            {/* <Image source={require('./cole.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 0}}/>
            <Image source={require('./cole.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 0}}/>
            <Image source={require('./cole.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 0}}/>
            <Image source={require('./cole.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 0}}/>
            <Image source={require('./cole.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 0}}/> */}
            </View>
            
            <View style={styles.button_bg}>
            <Button 
              title="start"
              ViewComponent={require('react-native-linear-gradient').default}
              titleStyle={{fontWeight: '600', fontSize: 30, fontFamily: 'Product Sans'}}
              linearGradientProps={{
                colors: ['#304FFE00', '#304FFE00'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
              }}
              buttonStyle={{borderWidth: 0, borderColor: 'white', borderWidth: 0 ,borderRadius: 35, height: 60}}
              containerStyle={{marginVertical: 10, height: 50, width: 350}}
              onPress={this.handleClick}
            /> 
            </View>
            
            </View>
            </View>
            
        );
      }
      else{
        return(<ARScene styled={0}/>);
      }
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
    top: height*.2
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
    paddingBottom: '15%'
  },
});


/*
<Image source={require('./cole.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./artem.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./micheal.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./isaac.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./jake.png')} style={{width: 100, height: 70, margin: 5}}/>
            */