import React, {Component} from 'react';
import {Image} from 'react-native'
import StyleView from './StyleView.js'
import { Button}  from 'react-native-elements';
import {Platform, StyleSheet, Text, View, UIManager, findNodeHandle, Dimensions, requireNativeComponent} from 'react-native';



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
    const btnStyle = {width: 350, alignSelf: "center", marginTop: 10 };
      if(this.state.home == 0){
        return (
          <View style={{flex: 1, flexDirection: 'column', alignContent: 'stretch', width: '100%', justifyContent: 'center', alignSelf: 'center' }}>
            <View style = {{position: 'absolute', top: 0, left: 0, bottom: 0, right: 0, zIndex: 0, backgroundColor: "#0064e8", opacity: 0.25, height: 900}}></View>
             <Image source={require('./bg.jpg')} style ={styles.image} />
          <View styles={styles.root} >
            <Text style ={styles.welcome1}>Stage a room...</Text>
            <Text style ={styles.welcome2}>virtually</Text>
            <Text style ={styles.welcome3}></Text>
            <View style={styles.button_bg}>
            <Button 
              title="Begin"
              ViewComponent={require('react-native-linear-gradient').default}
              titleStyle={{fontWeight: 'bold', fontSize: 18}}
              linearGradientProps={{
                colors: ['#0064e8', '#00ffed'],
                start: [1, 0],
                end: [0.2, 0],
              }}
              buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 10, height: 60}}
              containerStyle={{marginVertical: 10, height: 100, width: 350}}
              onPress={this.handleClick}
            /> 
            </View>
            </View>
            </View>
            
        );
      }
      else{
        return(<StyleView/>);
      }
    }
}


const styles = StyleSheet.create({
  root:{
    flex:1,
    justifyContent: 'space-evenly',
    alignItems: 'center',
    flexDirection: 'column',
    alignSelf: 'center',
    position: 'absolute',
    top: 100
  },
  welcome1: {
    color: "#FFFFFF", 
    fontWeight: "bold", 
    fontSize: 38, 
    width: '100%',
    textAlign: 'left',
    paddingBottom: 25,
    paddingLeft: 25
  },
  welcome2: {
    color: "#FFFFFF", 
    fontWeight: "bold", 
    fontSize: 30, 
    width: '100%',
    textAlign: 'right',
    paddingBottom: 20,
    paddingRight: 100,
    fontStyle: 'italic'
  },
  welcome3: {
    color: "#FFFFFF", 
    fontWeight: "bold", 
    fontSize: 25, 
    width: '100%',
    textAlign: 'center',
    paddingBottom: 100
  },
  image: {
    position: "absolute",
    resizeMode: 'stretch',
    height: 900,
    zIndex: -1,
    
  },
  button_bg: {
    alignSelf: 'center',
    paddingTop: 350
  },
});


