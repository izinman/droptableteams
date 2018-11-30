import React, {Component} from 'react';
import {Image} from 'react-native'
import StyleView from './StyleView.js'
import { Button}  from 'react-native-elements';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, Dimensions, requireNativeComponent} from 'react-native';
import ARScene from './ARView.js';



type Props = {};
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
          <View style={{ flex: 1, flexDirection: 'row', alignContent: 'flex-start', width: '100%', justifyContent: 'center', alignSelf: 'center' }}>
            <View style = {{position: 'absolute', top: 0, left: 0, bottom: 0, right: 0, zIndex: 0, backgroundColor: "#000000", opacity: 0.55, height: 900}}></View>
             <Image source={require('./bg.jpg')} style ={styles.image} blurRadius = {2}/>
          <View styles={styles.root} >
            <Text style ={styles.welcome1}>Stage your property...</Text>
            <Text style ={styles.welcome2}>virtually</Text>
            <Text style ={styles.welcome3}>With us</Text>
            <View style={{flex: 1, flexDirection: 'row', flexWrap: 'wrap', justifyContent:'center', alignContent: 'center',height: 20}}>
            <Image source={require('./cole.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 50}}/>
            <Image source={require('./artem.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 50}}/>
            <Image source={require('./micheal.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 50}}/>
            <Image source={require('./isaac.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 50}}/>
            <Image source={require('./jake.png')} style={{width: 100, height: 100, margin: 5, borderRadius: 50}}/>
            </View>
            <View style={styles.button_bg}>
            <Button 
              title="start"
              ViewComponent={require('react-native-linear-gradient').default}
              titleStyle={{fontWeight: '600', fontSize: 16}}
              linearGradientProps={{
                colors: ['#3a43ba', '#01458e'],
                  start: {x:0, y:0},
                  end: {x:0.5, y:0},
              }}
              buttonStyle={{borderWidth: 0, borderColor: 'white', borderWidth: 0 ,borderRadius: 35, height: 40}}
              containerStyle={{marginVertical: 10, height: 50, width: 250}}
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
  welcome1: {

    color: "#FFFFFF", 
    fontWeight: '300',
    fontSize: 34, 
    alignSelf: 'center',
    textAlign: 'center',
    paddingBottom: 55,
    paddingTop: '20%',
  },
  welcome2: {
    color: "#FFFFFF", 
    fontWeight: "bold", 
    fontSize: 30, 
    width: '100%',
    textAlign: 'center',
    fontStyle: 'italic',
    paddingBottom: '35%'
  },
  welcome3: {
    color: "#FFFFFF", 
    fontWeight: "300", 
    fontSize: 25, 
    width: '100%',
    textAlign: 'center',
    paddingBottom: "5%"
  },
  image: {
    position: "absolute",
    resizeMode: 'stretch',
    height: '100%',
    zIndex: -1,
    
    
  },
  button_bg: {
    alignSelf: 'center',
    paddingBottom: '20%'
  },
});


/*
<Image source={require('./cole.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./artem.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./micheal.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./isaac.png')} style={{width: 100, height: 70, margin: 5}}/>
            <Image source={require('./jake.png')} style={{width: 100, height: 70, margin: 5}}/>
            */