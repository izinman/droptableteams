import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View } from 'react-native'
import  Design  from "./Design.js"
import Furniture from './Furniture.js'
import {Button} from 'react-native-elements'
import ARScene from './ARView.js';

type Props = {};
var modern = require('./modern.jpg');
var contemporary = require('./contemporary.jpg');
var minimalist = require('./minimalist.jpg' );
var industrial = require('./industrial.jpg');
var  mid_century_modern = require('./mid-century-modern.jpg');
var  scandanavian = require('./scandanavian.jpg');
var traditional = require('./traditional.jpg');
var transitional = require('./transitional.jpg');
var bohemian = require('./bohemian.jpg');
var descMod = "Modern is a broad design term that typically refers to a home with clean, crisp lines, a simple colour palette and the use of materials that can include metal, glass and steel."
var descCon = "Modern and contemporary are two styles frequently used interchangeably. Contemporary is different from modern because it describes design based on the here and now."
var descMin = "Colour palettes are neutral and airy; furnishings are simple and streamlined, and nothing is excessive or flamboyant in accessories or décor. Minimalism is ultimately defined by a sense of functionality and ultra-clean lines."
var descInd = "There’s a sense of unfinished rawness in many of the elements, and it’s not uncommon to see exposed brick, ductwork and wood. An iconic home with an industrial design theme would be a renovated loft from a former industrial building."
var descMid = "Mid-century modern is a throwback to the design style of the mid-1900s—primarily the 1950s and 60s. There’s a retro nostalgia present in Mid-Century Modern Design, and also some elements of minimalism. Functionality or “fussy-free” was the main theme for Mid-century design. "
var descScan = "Scandanavian design pays homage to the simplicity of life demonstrated in Nordic countries. Scandinavian furniture design often feels like a work of art, although it is simple and understated. There’s functionality in the furniture along with some interesting lines, many of which have a sculptural influence."
var descTrad = "Traditional homes often feature dark, finished wood, rich colour palettes, and a variety of textures and curved lines. Furnishings have elaborate and ornate details and fabrics, like velvet, silk and brocade, which may include a variety of patterns and textures."
var descTrans = "A transitional design may incorporate modern materials, such as steel and glass, and then unite them with plush furnishings."
var descBoh = "Bohemian homes may include vintage furniture and light fixtures, globally inspired textiles and rugs, displays of collections, and items found in widely varied sources including flea markets and during one’s travels."

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
    if(this.state.start == 0){
    return (
      <View style= {{height: '100%', width: '100%'}}>
        <ScrollView styles={styles.container} >
          <View style={{flex: 1, flexWrap: 'wrap', flexDirection: 'row', height: '100%', justifyContent: 'center', alignItems: 'stretch', alignContent: 'stretch'}}>
              <View>
                <Design src={modern} name="modern" desc={descMod}/>
                </View>
              <View>
                <Design src={contemporary} name="contemporary" desc={descCon}/>
                </View>
              <View> 
                <Design src={minimalist} name="minimalist" desc={descMin}/>
                </View>
              <View> 
                <Design src={industrial} name ="industrial" desc={descInd}/>
                </View>
              <View> 
                <Design src={mid_century_modern} name="mid-century modern" desc={descMid}/>
                </View>
              <View>
                <Design src={scandanavian} name="scandanavian" desc={descScan}/>
                </View>
              <View>
                <Design src={traditional} name="traditional" desc={descTrad}/>
                </View>
              <View>
                <Design src={transitional} name="transitional" desc={descTrans}/>
                </View>
              <View>
                <Design src={bohemian} name="bohemian" desc={descBoh}/>
                </View>
              </View>
        </ScrollView>
        <View style={{position: 'absolute', bottom: 20 ,alignSelf: 'center' }}>
          <Button     
            title="continue"
            ViewComponent={require('react-native-linear-gradient').default}
            titleStyle={{fontWeight: '500', fontSize: 14}}
            linearGradientProps={{
              colors: ['#3a43ba', '#01458e'],
              start: {x:1, y:0},
              end: {x: 0.5, y: 0},
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
        <Furniture src = 'https://www.ikea.com/us/en/images/products/karlstad-sofa-gray__0404895_PE577343_S4.JPG' name='couch'/>
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

      