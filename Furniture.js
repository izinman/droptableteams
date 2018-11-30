import React, {Component} from 'react';
import { StyleSheet, Dimensions, ScrollView, View, Image} from 'react-native'
import ARScene from "./ARView.js"
import { Button, Tile}  from 'react-native-elements';
import Icon from 'react-native-vector-icons/FontAwesome';
import Design from './Design.js'


type Props = {};
export default class Furniture extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {start: 0};
    this.handleClick = this.handleClick.bind(this);
}
handleClick = () => {
    console.log("working");
    this.setState({
        start: 1,
        width: Dimensions.get('window').width
    });
  }
    render() {
        const  width  = this.state.width;
        if(this.state.start == 0){
        return(
            
            <View style = {{
                backgroundColor: '#FFFFFF', 
                flex: 1, 
                flexDirection: 'column', 
                alignSelf: 'center', 
                alignItems: 'center', 
                alignContent: 'center', 
                justifyContent: 'center', 
                width: '100%'}}>
            <ScrollView>
            <View style={{
                backgroundColor: '#FFFFFF',
                width: '100%',
                flex: 1,
                flexWrap: 'wrap',
                flexDirection: 'row',
                alignItems: 'center',
                alignSelf: 'center',
                alignContent: 'space-between',
                justifyContent: 'center',
                paddingTop: '25%'}} >
                <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 10, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              
                
              
              
            </View>
            </ScrollView>
           </View>
               
            );
            
        }
        else{
            return (
                <ARScene styled = {1}/>
            );
        }
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: "#f2f245",
        flexDirection: 'row',
        alignItems: 'center',
        paddingTop: 150
      },
    container1: {
        width: 100,
        flexWrap: 'wrap',
    },
    image:{
        height: 75,
        width: 100,
        marginTop: 5,
        marginLeft: 5,
        marginRight: 5,
        marginBottom: 5
    }
  });

  /*
  
  */