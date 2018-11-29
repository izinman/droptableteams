import React, {Component} from 'react';
import { StyleSheet, Text, View } from 'react-native'
import {Tile, Card} from 'react-native-elements';
import { Button } from 'react-native-elements';



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
        if(this.state.selected == 0){
        return(
            <Button     
                    title={this.props.title}
                    ViewComponent={require('react-native-linear-gradient').default}
                    titleStyle={{fontWeight: '400', fontSize: 12}}
                    linearGradientProps={{
                        colors: ['#3bba49', '#007c0d'],
                        start: {x:1, y:0},
                        end: {x: 0.2, y: 0},
                    }}
                    buttonStyle={{borderWidth: 0, borderColor: 'white', borderWidth: this.props.border, borderRadius: 8, height: 35}}
                    containerStyle={{marginVertical: 10, height: 35, width: 60, alignSelf: 'center'}}
                    onPress = {this.handleClick}
            /> 
        );
                }
        else{
            return(
            <Button     
            title={this.props.title + 'ed'}
            ViewComponent={require('react-native-linear-gradient').default}
            titleStyle={{fontWeight: '400', fontSize: 12}}
            linearGradientProps={{
                colors: ['#9d9ea0', '#636970'],
                start: {x:1, y:0},
                end: {x: 0.2, y: 0},
            }}
            buttonStyle={{borderWidth: 0, borderColor: 'white', borderWidth: this.props.border, borderRadius: 8, height: 35}}
            containerStyle={{marginVertical: 10, height: 35, width: 60, alignSelf: 'center'}}
            onPress = {this.handleClick}
    /> 
            );
                }
    }
}