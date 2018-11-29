import React, {Component} from 'react';
import { StyleSheet, Text, View } from 'react-native'
import {Tile, Card} from 'react-native-elements';
import { Button } from 'react-native-elements';
import DT_Button from './DT_Button.js'



type Props = {};
export default class Design extends Component<Props> {
    constructor(props) {
        super(props);
        this.state = {
            selected: 0,
            src: './bg.jpg'        }
    }
    componentDidMount(){
        if (this.props.src  == null){
            this.setState({src: './bg.jpg'})
        }

}
    handleClick = () => {
        if(this.state.selected == 1){
            this.setState({selected: 0});
        }      
        else{
            this.setState({selected: 1});
        }  
    }
    handleSelect = () => {
        
    }
  render() {
      var desc = this.props.src;
      if(this.state.selected == 0){
    return (

        <View style={styles.container}>
        <Tile
            imageSrc={require('./bg.jpg')}
            title = {this.props.name}
            titleStyle={{ fontSize: 25, fontWeight: 'bold' }}
            featured
            activeOpacity={1}
            onPress={this.handleClick}
              />
              </View>
    );
        }
        else{
            return(
                <View style={styles.container}>
                <View style= {styles.selected}>
                <Text style={{
                    fontSize: 18,
                    fontWeight: '400',
                    textAlign: "center", 
                    position: 'absolute', 
                    top: '5%', 
                    width: '90%', 
                    textAlignVertical: 'center', 
                    color: 'white',
                    alignSelf: 'center'
                    }}>{this.props.desc}</Text>
                <View style={{position: 'absolute', bottom: 0, right: 0, zIndex: 10, padding: 25}}>
                <View onPress={this.handleSelect}>
                <DT_Button title="select" color2 = "#0f9b1e" color1= "#3bba49" border = {0} />
                </View>
            </View>
                <Tile
                    imageSrc={require('./bg.jpg')}
                    imageContainerStyle={{opacity: .15 }}
                    titleStyle={{ fontSize: 25, fontWeight: 'bold' }}
                    featured
                    activeOpacity={1}
                    onPress={this.handleClick}
              />
              </View>
              </View>
                    
            );
        }
  }
}



const styles = StyleSheet.create({
container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
},
selected: {
    backgroundColor: '#000000',
   alignSelf: 'center'
}
});

/*
<Text style={{
                    fontSize: 20,
                    fontWeight: 'bold',
                    textAlign: "center", 
                    position: 'absolute', 
                    top: '50%', 
                    width: '100%', 
                    textAlignVertical: 'center', 
                    color: 'white'
                    }}>{this.props.desc}</Text>
                    */