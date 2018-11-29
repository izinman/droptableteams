import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View } from 'react-native'
import  Design  from "./Design.js"
import Furniture from './Furniture.js'
import {Button} from 'react-native-elements'
import ARScene from './ARView.js';

type Props = {};
export default class StyleView extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {start: 0,
                  selected: 'contemporary'};
    this.handleClick = this.handleClick.bind(this);
}
  handleClick = () => {
    console.log("working");
    this.setState({start: 1});
  }
  render() {
    var instruction = "Select " + this.state.selected + " furniture"
    var desc = "Cilurut recan igoyem pida ramula rola udoralut lihet, refe tase emerol nirad unowatap diehef codun ahadidir, detos polaca doney liel tomur merec resasu da ulita ofu; sopo osotos galed ofumice gabiha nep esies nitu, hes ho eme nobe oreyer relerer gariya diesa te nesiti. Net wef ru erukatib dikepo etie rin sasif irete liehitog"
    if(this.state.start == 0){
    return (
      <View style= {{height: '100%', width: '100%'}}>
        <ScrollView styles={styles.container} >
          <View style={{flex: 1, flexWrap: 'wrap', flexDirection: 'row', height: '100%', justifyContent: 'center', alignItems: 'stretch', alignContent: 'stretch'}}>
              <View>
                <Design src='./bg.jpg' name="modern" desc={desc}/>
                </View>
              <View>
                <Design src='./bg.jpg' name="contemporary" desc={desc}/>
                </View>
              <View> 
                <Design src='./bg.jpg' name="minimalist" desc={desc}/>
                </View>
              <View> 
                <Design src='./bg.jpg'name ="industrial" desc={desc}/>
                </View>
              <View> 
                <Design src='./bg.jpg'name="mid-century modern" desc={desc}/>
                </View>
              <View>
                <Design src='./bg.jpg'name="scandanavian" desc={desc}/>
                </View>
              <View>
                <Design src='./bg.jpg'name="traditional" desc={desc}/>
                </View>
              <View>
                <Design src='./bg.jpg'name="transitional" desc={desc}/>
                </View>
              <View>
                <Design src='./bg.jpg'name="bohemian" desc={desc}/>
                </View>
              </View>
        </ScrollView>
        <View style={{position: 'absolute', bottom: 20 ,alignSelf: 'center' }}>
          <Button     
            title="continue"
            ViewComponent={require('react-native-linear-gradient').default}
            titleStyle={{fontWeight: '400', fontSize: 12}}
            linearGradientProps={{
              colors: ['#1452ce', '#3a7cff'],
              start: {x:1, y:0},
              end: {x: 0.2, y: 0},
            }}
            buttonStyle={{borderWidth: 0, borderColor: 'white', borderWidth: 0, borderRadius: 10, height: 45}}
            containerStyle={{marginVertical: 10, height: 40, width: 300, alignSelf: 'center'}}
            onPress = {this.handleClick}
            /> 
          </View>
       </View>



    );
    }
    else{
      return(
        <ARScene/>
      );
    }
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#f2f245",
    height: '100%',
    width: '100%'
  },
});

      