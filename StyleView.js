import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View, Picker, Animated } from 'react-native'
import { Dropdown } from 'react-native-material-dropdown';
import {Tile} from 'react-native-elements'
import ARScene from './ARView.js';

type Props = {};
var all = require('./all.jpeg');
var familyroom = require('./familyroom.jpg');
var kitchen = require('./kitchen.jpg');
var diningroom = require('./diningroom.jpg' );
var bedroom = require('./bedroom.jpg');
var  gameroom = require('./gameroom.jpg');
var  dungeon = require('./dungeon.jpg');
var office = require('./office.jpg');
var couches = [require('./couches/3.jpeg'),require('./couches/1.jpeg'),require('./couches/2.jpeg'),require('./couches/4.jpeg')];
var chairs = [require('./chairs/3.jpeg'),require('./chairs/1.jpeg'),require('./chairs/2.jpeg'),require('./chairs/4.jpeg'),require('./chairs/6.jpeg')];
var tables= [require('./tables/1.jpeg'),require('./tables/2.jpeg'),require('./tables/3.jpeg'),require('./tables/4.jpeg')];
var misc= [require('./misc/1.jpeg'),require('./misc/2.jpg'),require('./misc/3.jpeg'),require('./misc/4.jpg'),require('./misc/5.jpg'),require('./misc/6.jpeg'),require('./misc/7.jpeg')];
var beds= [require('./bed/1.jpg'),require('./bed/2.jpeg'),require('./bed/3.jpg'),require('./bed/4.jpeg'),require('./bed/5.jpeg'),require('./bed/6.jpeg'),require('./bed/7.jpg')];

const HEADER_MAX_HEIGHT = 600;
const HEADER_MIN_HEIGHT = 160;
const HEADER_SCROLL_DISTANCE = HEADER_MAX_HEIGHT - HEADER_MIN_HEIGHT;
const ACCENT_COLOR = '#FFC107'


export default class StyleView extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {start: 0,
                  selected: 'contemporary',
                  img: all,
                  room: "All",
                  couchesOn: '#232323',
                  scrollY: new Animated.Value(0),};
    this.handleClick = this.handleClick.bind(this);
    this.handleDropDown = this.handleDropDown.bind(this);
  }
  handleClick = () => {
    console.log("working");
    this.setState({start: 1});
  }

  handleDropDown(text) {
    var newImg = '';
    text == 'Family Room' ? newImg = familyroom:
    text == 'Kitchen' ? newImg = kitchen :
    text == 'Dining Room' ? newImg = diningroom :
    text == 'Bedroom' ? newImg = bedroom :
    text == 'Game Room' ? newImg = gameroom :  
    text == 'Office' ? newImg = office :
    text == 'Dungeon' ? newImg = dungeon :
    newImg = all;
    this.setState({img: newImg, room: text})
    console.log(text);
  }

  _renderScrollViewContent(title) {
    var couchesData = Array.from({length: 4});
    var chairsData = Array.from({length: 5});
    var tablesData = Array.from({length: 4});
    var miscData = Array.from({length: 7});
    var bedData = Array.from({length: 6});




    var data = Array.from({length: 10});

    return (
      <View>
      <View style={styles.scrollViewContent}>
      <Text style = {{paddingLeft: 25, paddingTop: 25, fontFamily: 'Product Sans', fontSize: 45, color: '#232323'}}>{this.state.room}</Text>
      <Text style = {{width: '100%', padding: 45, fontSize: 35, fontFamily: 'Product Sans', color: this.state.couchesOn}}>Couches</Text>
        {couchesData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: 20, alignSelf:'flex-start'}}>
                <Tile
                    imageSrc={couches[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={225}
                    onPress={this.handleClick}
              />
              </View>
          </View>
          
        )}
        <Text style = {{width: '100%', padding: 45, fontSize: 35,  fontFamily: 'Product Sans'}}>Chairs</Text>
        {chairsData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: 20, alignSelf:'flex-start'}}>
                <Tile
                    imageSrc={chairs[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={225}
                    onPress={this.handleClick}
              />
              </View>
          </View>
          
        )}
        <Text style = {{width: '100%', padding: 45, fontSize: 35, fontFamily: 'Product Sans'}}>Tables</Text>
        {tablesData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: 20, alignSelf:'flex-start'}}>
                <Tile
                    imageSrc={tables[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={225}
                    onPress={this.handleClick}
              />
              </View>
          </View>
          
        )}
        <Text style = {{width: '100%', padding: 45, fontSize: 35,  fontFamily: 'Product Sans'}}>Beds</Text>
        {bedData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: 20, alignSelf:'center'}}>
                <Tile
                    imageSrc={ beds[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={205}
                    onPress={this.handleClick}
              />
              </View>
          </View>
          
        )}
        <Text style = {{width: '100%', padding: 45, fontSize: 35,  fontFamily: 'Product Sans'}}>Misc.</Text>
        {miscData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: 20, alignSelf:'center'}}>
                <Tile
                    imageSrc={ misc[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={205}
                    onPress={this.handleClick}
              />
              </View>
          </View>
          
        )}
      </View>
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
      value: 'All',
    }, {
      value: 'Family Room',
    }, 
    {
      value: 'Bedroom',
    },
    {
      value: 'Kitchen',
    },
    {
      value: 'Dining Room',
    },
    {
      value: 'Office',
    },
    {
      value: 'Game Room',
    },{
      value: 'Dungeon',
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
            {this._renderScrollViewContent('Couches')
          }
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
                  baseColor='#304ffe'
                  label='Room'
                  textColor='#304ffe'
                  itemColor="#232323"
                  fontSize={35}
                  pickerStyle={{backgroundColor:"#ffffff" }}
                  labelFontSize={25}
                  selectedItemColor="#232323"
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
      backgroundColor: '#ffffffd0'
    },
    dropdown:{
      paddingTop: 25,
      margin: HEADER_MIN_HEIGHT/8,
      width: '90%',

    },
    fill: {
      zIndex: -10,
      backgroundColor: '#ffffff',
      width: '100%',
      alignSelf:'center'
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
      backgroundColor: '#ffffff',
      flexBasis: "33%"
    },
    header: {
      position: 'absolute',
      top: 0,
      left: 0,
      right: 0,
      shadowColor: 'black',
      shadowOpacity: 1.0,
      backgroundColor: '#ffffff',
      overflow: 'hidden',
    },
    bar: {
      width: '100%',
      marginTop: 0,
      height: 32,
      alignItems: 'flex-start',
      justifyContent: 'flex-start',
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
      justifyContent:'flex-start',
      alignItems: 'flex-start',
      alignSelf: 'flex-start',
      flexDirection: 'row',
      flexWrap: 'wrap',
      
    },
  container: {
    backgroundColor: "#FFD54F",
    height: '100%',
    width: '100%',
    
  },
});