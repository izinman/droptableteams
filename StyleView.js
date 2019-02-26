import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View, Picker, Animated, UIManager, findNodeHandle, requireNativeComponent, Dimensions } from 'react-native'
import { Dropdown } from 'react-native-material-dropdown';
import {Tile, Button} from 'react-native-elements'
import LinearGradient from 'react-native-linear-gradient';
import Icon from 'react-native-vector-icons/Feather';
import AnimateView from './AnimateView.js'

type Props = {};
var objectSelected
var {height, width} = Dimensions.get('window');
var headerFont = height * .032
var subheaderFont = height * .027
var all = require('./all.jpeg');
var familyroom = require('./familyroom.jpg');
var kitchen = require('./kitchen.jpg');
var diningroom = require('./diningroom.jpg' );
var bedroom = require('./bedroom.jpg');
var  gameroom = require('./gameroom.jpg');
var  dungeon = require('./dungeon.jpg');
var office = require('./office.jpg');
var couches = [require('./couches/1.jpg'),require('./couches/2.jpg'),require('./couches/3.jpg'),require('./couches/4.jpg'),require('./couches/5.jpg'),require('./couches/6.jpg'),require('./couches/7.jpg'),require('./couches/8.jpg'),require('./couches/9.jpg'),require('./couches/10.jpg'),require('./couches/11.jpg'),require('./couches/12.jpg')];
var chairs = [require('./chairs/1.jpg'),require('./chairs/2.jpg'),require('./chairs/3.jpg'),require('./chairs/4.jpg'),require('./chairs/5.jpg'),require('./chairs/6.jpg'),require('./chairs/7.jpg'),require('./chairs/8.jpg'),require('./chairs/9.jpg')];
var tables= [require('./tables/1.jpg'),require('./tables/2.jpg'),require('./tables/3.jpg'),require('./tables/4.jpg'),require('./tables/5.jpg'),require('./tables/6.jpg'),require('./tables/7.jpg'),require('./tables/8.jpg'),require('./tables/9.jpg')];
var misc= [require('./misc/1.jpeg'),require('./misc/2.jpg'),require('./misc/3.jpeg'),require('./misc/4.jpg'),require('./misc/5.jpg'),require('./misc/6.jpeg'),require('./misc/7.jpeg')];
var beds= [require('./bed/1.jpg'),require('./bed/2.jpg'),require('./bed/3.jpg'),require('./bed/4.jpg'),require('./bed/5.jpg'),require('./bed/6.jpg'),require('./bed/7.jpg'),require('./bed/8.jpg'),require('./bed/9.jpg'),require('./bed/10.jpg')];

var cabinets= [require('./cabinets/1.jpg'),require('./cabinets/2.jpg'),require('./cabinets/3.jpg'),require('./cabinets/4.jpg'),require('./cabinets/5.jpg'),require('./cabinets/6.jpg'),require('./cabinets/7.jpg'),require('./cabinets/8.jpg'),require('./cabinets/9.jpg'),require('./cabinets/10.jpg'),require('./cabinets/11.jpg'),require('./cabinets/12.jpg')]
var appliances= [require('./appliances/1.jpg'),require('./appliances/2.jpg'),require('./appliances/3.jpg'),require('./appliances/4.jpg'),require('./appliances/5.jpg'),require('./appliances/6.jpg'),require('./appliances/7.jpg'),require('./appliances/8.jpg'),require('./appliances/9.jpg'),require('./appliances/10.jpg'),require('./appliances/11.jpg'),require('./appliances/12.jpg'),require('./appliances/13.jpg')]

const HEADER_MAX_HEIGHT = height*.43;
const HEADER_MIN_HEIGHT = height*.16;
const HEADER_SCROLL_DISTANCE = HEADER_MAX_HEIGHT - HEADER_MIN_HEIGHT;
const ACCENT_COLOR = '#FFC107'


export default class StyleView extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {start: 0,
                  selected: 'contemporary',
                  img: all,
                  room: "All",
                  scrollY: new Animated.Value(0),
                  couchesOn: true,
                  bedsOn: true,
                  chairsOn: true,
                  tablesOn: true,
                  miscOn: true,
                  appliancesOn: true};
    this.handleClick = this.handleClick.bind(this);
    this.handleDropDown = this.handleDropDown.bind(this);
  }

  componentDidMount() {
    this.nodeHandle = findNodeHandle(this.ref);
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
    switch(text){
      case "Family Room":
        this.setState({couchesOn: true, bedsOn: false, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: false})
        break;
      case "Kitchen":
        this.setState({couchesOn: false, bedsOn: false, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: true})
        break;
      case "Dining Room":
        this.setState({couchesOn: false, bedsOn: false, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: false})
        break;
      case "Bedroom":
      this.setState({couchesOn: false, bedsOn: true, miscOn: true, tablesOn: false, chairsOn: true, appliancesOn: false})
        break;
      case "Game Room":
      this.setState({couchesOn: true, bedsOn: false, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: true})
        break;
      case "Office":
      this.setState({couchesOn: false, bedsOn: false, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: false})
        break;
      case "Dungeon":
      this.setState({couchesOn: true, bedsOn: true, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: true})
        break;
      default:
      this.setState({couchesOn: true, bedsOn: false, miscOn: true, tablesOn: true, chairsOn: true, appliancesOn: false})
      
    }
    this.setState({img: newImg, room: text})
    console.log(text);
  }

  _renderScrollViewContent(title) {
    var couchesData = Array.from({length: 12});
    var chairsData = Array.from({length: 9});
    var tablesData = Array.from({length: 9});
    var miscData = Array.from({length: 7});
    var bedData = Array.from({length: 10});
    var cabinetData = Array.from({length: 12});
    var applianceData = Array.from({length: 13});




    var data = Array.from({length: 10});

    return (
    
      <AnimateView>
        <View>
        <View style={styles.scrollViewContent}>
      
      <Text style = {{textAlign: 'left', width: '100%',  paddingTop: height * .04, paddingLeft: width * .02, paddingBottom: height * .02, fontFamily: 'Product Sans', fontSize: headerFont, color: '#232323'}}>{this.state.room}</Text>
      <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Couches</Text>
      <View style = {{height: 2,width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
      {couchesData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01 , alignSelf:'center'}}>
                <Tile
                    imageSrc={couches[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .16875}
                    onPress={this.handleClick.bind(this,'couch' + i)}
              />
              </View>
          </View>
          
        )}
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Chairs</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
        {chairsData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01, alignSelf:'center'}}>
                <Tile
                    imageSrc={chairs[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .30}
                    onPress={this.handleClick.bind(this,'chair' + i)}
              />
              </View>
          </View>
          
        )}
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Tables</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
        {tablesData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01, alignSelf:'center'}}>
                <Tile
                    imageSrc={tables[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .30}
                    onPress={this.handleClick.bind(this,'table' + i)}
              />
              </View>
          </View>
          
        )}
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Beds</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
        {bedData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01, alignSelf:'center'}}>
                <Tile
                    imageSrc={ beds[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .30}
                    onPress={this.handleClick}
              />
              </View>
          </View>
          
        )}
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Cabinets</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
        {cabinetData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01, alignSelf:'center'}}>
                <Tile
                    imageSrc={ cabinets[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .30}
                    onPress={this.handleClick.bind(this, 'cabinet' + i)}
              />
              </View>
          </View>
        )}
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Appliances</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
        {applianceData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01, alignSelf:'center'}}>
                <Tile
                    imageSrc={appliances[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .30}
                    onPress={this.handleClick}
              />
              </View>
          </View>
        )}
        {/* <Text style = {{width: '100%', paddingHorizontal: width * .05, paddingBottom: height * .02, paddingTop: height * .02, fontSize: subheaderFont, fontFamily: 'Product Sans', color: this.state.couchesOn}}>Misc</Text>
        {miscData.map((_, i) =>
          <View key={i} style={styles.row}>
             <View style={{padding: height * .01, alignSelf:'center'}}>
                <Tile
                    imageSrc={ misc[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .30}
                    height={width * .22}
                    onPress={this.handleClick.bind(this, "misc" + i)}
              />
              </View>
          </View>
          
        )} */}
      </View>
      </View>
      </AnimateView>
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
                  fontSize={headerFont}
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
        <Animated.View style = {{position: 'absolute', top: -height * .05, width: width, height: height * .05, backgroundColor: '#ffffff'}}>
          <Button 
                title=""
                ViewComponent={require('react-native-linear-gradient').default}
                linearGradientProps={{
                  colors: ['#ffffff', '#424242'],
                    start: {x:0, y:.7},
                    end: {x:0, y:1},
                }}
                icon={
                  <Icon
                    name="chevrons-up"
                    size={height * .03}
                    color="#008fbe"
                  />
                }
                buttonStyle={{height: height * .05, width: width}}
                containerStyle={{marginVertical: 0, height: height * .04}}
                onPress={this.props.onOpen}
          /> 
        </Animated.View>
        <View style = {{position: 'absolute', top: 0, width: width, height: height * .05, backgroundColor: '#ffffff'}}>
          <Button 
                title=""
                ViewComponent={require('react-native-linear-gradient').default}
                linearGradientProps={{
                  colors: ['#424242', '#ffffff'],
                    start: {x:0, y:0},
                    end: {x:0, y:.3},
                }}
                icon={
                  <Icon
                    name="chevrons-down"
                    size={height * .03}
                    color="#008fbe"
                  />
                }
                buttonStyle={{height: height * .05, width: width}}
                containerStyle={{marginVertical: 0, height: height * .04}}
                onPress={this.props.onClose}
          /> 
        </View>
        </View>      
      );
  }
  handleClick(e){
    console.log(e)
    this.props.onPress(e)
  }
  handleClose(){
    this.props.onClose()
  }
  handleOpen(){
    this.props.onOpen()
  }  
  selectObject = () => {
    UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.ref),
        UIManager[Style].Commands.setObjectToPlace,
        [objectSelected]
    );
  };
}

const Style = requireNativeComponent("StyleView")

const styles = StyleSheet.create({
    ddContainer:{
      position: 'absolute',
      width: "100%",
      top: height * .05,
      height: HEADER_MIN_HEIGHT,
    },
    ddContainerAnimated:{
      position: 'absolute',
      top: 0,
      width: "100%",
      height: HEADER_MIN_HEIGHT,
      backgroundColor: '#ffffffc5'
    },
    dropdown:{
     
      marginHorizontal: HEADER_MIN_HEIGHT/9,
      width: '90%',

    },
    fill: {
      zIndex: -10,
      backgroundColor: '#ffffffc5',
      height: height ,
      width: '100%',
      bottom: 0,
      alignSelf:'center'
    },
    backgroundImage: {
      position: 'absolute',
      top:  0,
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
      backgroundColor: '#00000000',
      flexBasis: width/3,
    },
    header: {
      position: 'absolute',
      top: 0,
      left: 0,
      right: 0,
      backgroundColor: '#ffffffc5',
      overflow: 'hidden',
    },
    bar: {
      width: '100%',
      marginTop: 0,
      height: 0,
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
      alignItems: 'stretch',
      alignSelf: 'center',
      flexDirection: 'row',
      flexWrap: 'wrap',
      
    },
  container: {
    backgroundColor: "#ffffffc5",
    height: '50%',
    width: '100%',
    
  },
});