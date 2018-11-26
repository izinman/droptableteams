import React, {Component} from 'react';
import { StyleSheet, Text, View } from 'react-native'
import {Tile, Card} from 'react-native-elements';
import { Button } from 'react-native';


type Props = {};
export default class Design extends Component<Props> {
    constructor(props) {
        super(props);
        this.state = {selected: 0}
    }
    handleClick = () => {
        if(this.state.selected == 1){
            this.setState({selected: 0});
        }      
        else{
            this.setState({selected: 1});
        }  
    }
  render() {
    return (
        <View style={styles.container}>
        <Tile
            imageSrc={{ uri: this.props.src }}
            title = {this.props.name}
            titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
            featured
            activeOpacity={.75}
            width={420}
            onPress={this.handleClick}
              />
              </View>
    );
  }
}



const styles = StyleSheet.create({
container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center'
},
});