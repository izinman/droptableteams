import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View, Picker, Animated } from 'react-native'
import { Dropdown } from 'react-native-material-dropdown';

import  Design  from "./Design.js"
import Furniture from './Furniture.js'
import {Button, Tile} from 'react-native-elements'
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
const HEADER_MAX_HEIGHT = 300;
const HEADER_MIN_HEIGHT = 120;
const HEADER_SCROLL_DISTANCE = HEADER_MAX_HEIGHT - HEADER_MIN_HEIGHT;
const ACCENT_COLOR = '#FFC107'


export default class StyleView extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {start: 0,
                  selected: 'contemporary',
                  img: modern,
                  desc: descMod,
                  scrollY: new Animated.Value(0),};
    this.handleClick = this.handleClick.bind(this);
    this.handleDropDown = this.handleDropDown.bind(this);
  }
  handleClick = () => {
    console.log("working");
    this.setState({start: 1});
  }
  handleDropDown(text) {
    var newDesc = '';
    var newImg = '';
    text == 'Contemporary' ? newDesc = descCon :
    text == 'Minimalist' ? newDesc = descMin :
    text == 'Mid-Century Modern' ? newDesc = descMid :
    text == 'Traditional' ? newDesc = descTrad :
    text == 'Scandanavian' ? newDesc = descScan :
    text == 'Transitional' ? newDesc = descTrans :
    text == 'Bohemian' ? newDesc = descBoh :
    newDesc = descInd
    text == 'Contemporary' ? newImg = contemporary:
    text == 'Minimalist' ? newImg = minimalist :
    text == 'Mid-Century Modern' ? newImg = mid_century_modern :
    text == 'Traditional' ? newImg = traditional :
    text == 'Scandanavian' ? newImg = scandanavian :  
    text == 'Transitional' ? newImg = transitional :
    text == 'Bohemian' ? newImg = bohemian :
    newImg = industrial;
    this.setState({img: newImg, desc: newDesc})
    console.log(text);
  }

  _renderScrollViewContent() {
    const data = Array.from({length: 30});
    return (
      <View style={styles.scrollViewContent}>
        {data.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: 2}}>
                <Tile
                    imageSrc={{ uri: "https://secure.img2-fg.wfcdn.com/im/88812946/compr-r85/3349/33499118/chisolm-loveseat.jpg" }}
                    title = "Couch"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={182}
                    onPress={this.handleClick}
              />
              </View>
          </View>
        )}
      </View>
    );
  }

  render() {  
    const headerHeight = this.state.scrollY.interpolate({
      inputRange: [0, HEADER_SCROLL_DISTANCE],
      outputRange: [HEADER_MAX_HEIGHT, HEADER_MIN_HEIGHT],
      extrapolate: 'clamp',
    });
    const imageOpacity = this.state.scrollY.interpolate({
      inputRange: [0, HEADER_SCROLL_DISTANCE / 2, HEADER_SCROLL_DISTANCE],
      outputRange: [1, 1, 0],
      extrapolate: 'clamp',
    });
    const imageTranslate = this.state.scrollY.interpolate({
      inputRange: [0, HEADER_SCROLL_DISTANCE],
      outputRange: [0, -50],
      extrapolate: 'clamp',
    });

    let data = [{
      value: 'Contemporary',
    }, {
      value: 'Minimalist',
    }, 
    {
      value: 'Mid-Century Modern',
    },
    {
      value: 'Traditional',
    },
    {
      value: 'Scandanavian',
    },
    {
      value: 'Transitional',
    },
    {
      value: 'Bohemian',
    },{
      value: 'Industrial',
    }];
    if(this.state.start == 0){
    return (
      <View style={styles.fill}>
        
        <ScrollView
          style={styles.fill}
          scrollEventThrottle={16}
          onScroll={Animated.event(
            [{nativeEvent: {contentOffset: {y: this.state.scrollY}}}]
          )}>
            {this._renderScrollViewContent()}
        </ScrollView>
        <Animated.View style={[styles.header, {height: headerHeight}]}>
          <Animated.Image
            style={[
              styles.backgroundImage,
              {opacity: imageOpacity, transform: [{translateY: imageTranslate}]},
            ]}
            source={this.state.img}
          />
          <Animated.View style ={[styles.ddContainerAnimated, {opacity: imageOpacity}]}></Animated.View>
          <View style={styles.bar}>
            <View style ={styles.ddContainer}>
              <View style={styles.dropdown}>
                <Dropdown
                  baseColor='#ffffff'
                  label='Furniture Style'
                  textColor='#ffffff'
                  textStyle={{fontWeight: '800'}}
                  itemColor="#ffffff"
                  fontSize={18}
                  pickerStyle={{backgroundColor:"#232323" }}
                  labelFontSize={16}
                  selectedItemColor="#ededed"
                  dropdownPosition={-5}
                  data={data}
                  onChangeText={this.handleDropDown}
                />
                </View>
              </View>
          </View>
        </Animated.View>
        </View>
      );
    }
    else{
      return(
        <ARScene></ARScene>
      );
    }
  }
}

const styles = StyleSheet.create({
    ddContainer:{
      position: 'absolute',
      top:0,
      width: "100%",
      height: HEADER_MIN_HEIGHT,
    },
    ddContainerAnimated:{
      position: 'absolute',
      top:0,
      width: "100%",
      height: HEADER_MIN_HEIGHT,
      backgroundColor: '#23232387'
    },
    dropdown:{
      margin: HEADER_MIN_HEIGHT/4,
      width: '80%',
    },
    fill: {
      zIndex: -10,
      backgroundColor: '#232323',
      width: '100%'
    },
    backgroundImage: {
      position: 'absolute',
      top: 0,
      left: 0,
      right: 0,
      width: null,
      height: HEADER_MAX_HEIGHT,
      
      resizeMode: 'cover',
    },
    scrollFlex:{
      width: '100%',
      flex:1,
      flexDirection: "row",
      flexWrap: "wrap",
      justifyContent: "flex-start",
      alignItems: "flex-start",

    },
    row: {
      backgroundColor: '#232323',
      flexGrow: 100,
      flexBasis: "50%"
    },
    header: {
      position: 'absolute',
      top: 0,
      left: 0,
      right: 0,
      shadowOffset:{  width: 10,  height: 10,  },
      shadowColor: 'black',
      shadowOpacity: 1.0,
      backgroundColor: '#3F51B5',
      overflow: 'hidden',
    },
    bar: {
      width: '100%',
      marginTop: 0,
      height: 32,
      alignItems: 'center',
      justifyContent: 'center',
    },
    title: {
      backgroundColor: 'transparent',
      color: 'white',
      fontSize: 18,
    },
    scrollViewContent: {
      marginTop: HEADER_MAX_HEIGHT,
      width: '100%',
      flex: 1,
      flexDirection: 'row',
      flexWrap: 'wrap',
      
    },
  container: {
    backgroundColor: "#FFD54F",
    height: '100%',
    width: '100%',
    
  },
});



/*
<View >
              <View style= {{position: 'absolute', top: 20}}>
              <ScrollView
                  onScroll={Animated.event(
                    [{nativeEvent: {contentOffset: {y: this.state.scrollY}}}]
                  )}>
                <Design src={this.state.img} name="" desc={this.state.desc}/>
                <View style={{backgroundColor: '#FFFFFF',
                width: '100%',
                flex: 1,
                flexGrow: 1,
                flexWrap: 'wrap',
                flexDirection: 'row',
                alignItems: 'stretch',
                alignSelf: 'center',
                alignContent: 'space-between',
                justifyContent: 'center'}}>
                <View style={{padding: 2}}>
                <Tile
                    imageContainerStyle={{width:'48%'}}
                    imageSrc={{ uri: "https://www.ikea.com/us/en/images/products/ekedalen-chair-brown__0516603_PE640439_S4.JPG" }}
                    title = "chair"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2}}>
                <Tile
                   imageContainerStyle={{width:'48%'}}
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2, }}>
                <Tile
                    imageSrc={{ uri: "https://www.knoll.com/static_resources/images/products/catalog/eco/parts/642TR/642TR-KC_KC_FZ.jpg" }}
                    title = "table"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2, }}>
                <Tile
                    imageSrc={{ uri: "https://havertys.scene7.com/is/image/Havertys/5-4598-0009?op_sharpen=1&wid=300&hei=225" }}
                    title = "bed"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2}}>
                <Tile
                    imageSrc={{ uri: "https://target.scene7.com/is/image/Target/GUEST_56048ba6-808e-46e4-974c-974fc89428ab?wid=488&hei=488&fmt=pjpeg" }}
                    title = "night stand"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2}}>
                <Tile
                    imageSrc={{ uri: "https://secure.img2-fg.wfcdn.com/im/88812946/compr-r85/3349/33499118/chisolm-loveseat.jpg" }}
                    title = "love seat"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2}}>
                <Tile
                    imageSrc={{ uri: "https://target.scene7.com/is/image/Target/GUEST_5a53b19a-0b88-4278-a819-9b50361a58c8?wid=488&hei=488&fmt=pjpeg" }}
                    title = "end table"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2}}>
                <Tile
                    imageSrc={{ uri: "https://i5.walmartimages.com/asr/60936740-826e-4cce-9275-4204ff3a76ef_1.ea9d1811c23382069dc741a4e07ce4ad.jpeg" }}
                    title = "rug"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 2}}>
                <Tile
                    imageSrc={{ uri: "https://www.ikea.com/us/en/images/products/angland-table-lamp-with-led-bulb__0385322_PE558444_S4.JPG" }}
                    title = "lamp"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
                </View>
                </ScrollView>
              </View>
              
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
          <View style = {{ paddingHorizontal: 25, paddingTop: 35, paddingBottom: 15,position: 'absolute', top: 0 ,
                            alignSelf: 'center', width: '100%', backgroundColor: '#2196F3',
                            shadowOffset: { height: 5 },
                            shadowColor: '#232323',
                            shadowOpacity: .4,
                            }}>
          <View >
              <Dropdown
                baseColor='#ffffff'
                label='Furniture Style'
                textColor='#ffffff'
                itemColor="#ffffff"
                containerStyle={{zIndex:-1}}
                fontSize={18}
                pickerStyle={{backgroundColor:"#000000c9" }}
                labelFontSize={16}
                selectedItemColor="#ededed"
                dropdownPosition={-5}
                data={data}
                onChangeText={this.handleDropDown}
              />
              </View>
              </View>
       </View>
      */