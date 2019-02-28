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
var all = require('./familyroom.jpg');
var couches = [require('./couches/1.jpg'),require('./couches/2.jpg'),require('./couches/3.jpg'),require('./couches/4.jpg'),require('./couches/5.jpg'),require('./couches/6.jpg'),require('./couches/7.jpg'),require('./couches/8.jpg'),require('./couches/9.jpg'),require('./couches/10.jpg'),require('./couches/11.jpg'),require('./couches/12.jpg')];
var chairs = [require('./chairs/1.jpg'),require('./chairs/2.jpg'),require('./chairs/3.jpg'),require('./chairs/4.jpg'),require('./chairs/5.jpg'),require('./chairs/6.jpg'),require('./chairs/7.jpg'),require('./chairs/8.jpg'),require('./chairs/9.jpg')];
var tables= [require('./tables/1.jpg'),require('./tables/2.jpg'),require('./tables/3.jpg'),require('./tables/4.jpg'),require('./tables/5.jpg'),require('./tables/6.jpg'),require('./tables/7.jpg'),require('./tables/8.jpg'),require('./tables/9.jpg')];
var beds= [require('./bed/1.jpg'),require('./bed/2.jpg'),require('./bed/3.jpg'),require('./bed/4.jpg'),require('./bed/5.jpg'),require('./bed/6.jpg'),require('./bed/7.jpg'),require('./bed/8.jpg'),require('./bed/9.jpg'),require('./bed/10.jpg')];
var cabinets= [require('./cabinets/1.jpg'),require('./cabinets/2.jpg'),require('./cabinets/3.jpg'),require('./cabinets/4.jpg'),require('./cabinets/5.jpg'),require('./cabinets/6.jpg'),require('./cabinets/7.jpg'),require('./cabinets/8.jpg'),require('./cabinets/9.jpg'),require('./cabinets/10.jpg'),require('./cabinets/11.jpg'),require('./cabinets/12.jpg')]
var appliances= [require('./appliances/1.jpg'),require('./appliances/2.jpg'),require('./appliances/3.jpg'),require('./appliances/4.jpg'),require('./appliances/5.jpg'),require('./appliances/6.jpg'),require('./appliances/7.jpg'),require('./appliances/8.jpg'),require('./appliances/9.jpg'),require('./appliances/10.jpg'),require('./appliances/11.jpg'),require('./appliances/12.jpg'),require('./appliances/13.jpg')]
const HEADER_MAX_HEIGHT = height*.25;
const HEADER_MIN_HEIGHT = height*.05;
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
                  animatedStartValue: new Animated.Value(0)};
    this.handleClick = this.handleClick.bind(this);
  }
  componentDidMount() {
    this.nodeHandle = findNodeHandle(this.ref);
    Animated.loop(
      Animated.sequence([
        Animated.timing(this.state.animatedStartValue, {
          toValue: 1,
          duration: 450,
          
        }),
        Animated.timing(this.state.animatedStartValue, {
          toValue: 0,
          duration: 450,
        })
      ]),
      {
        iterations: 4000
      }
    ).start()
  }

  handleDropDown(text) {
    var newImg = '';
    newImg = all;
    this.setState({img: newImg, room: text})
    console.log(text);
  }

  _renderScrollViewContent(title) {
    var couchesData = Array.from({length: 12});
    var chairsData = Array.from({length: 9});
    var tablesData = Array.from({length: 9});
    var bedData = Array.from({length: 10});
    var cabinetData = Array.from({length: 12});
    var applianceData = Array.from({length: 13});
    return (
      <AnimateView>
        <View>
          <View>
            <View style = {styles.scrollViewContent}>
              <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
                <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Couches</Text>
                <View style = {{height: 2,width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
              </View>    
          </View>
          <ScrollView horizontal= {true} >
          <View style = {styles.horizontalWide}>
            {couchesData.map((_, i) =>
              <View key={i} style={styles.row}>
                <View style={{paddingLeft: height * .02, paddingBottom: height * .02, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
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
            </View>
            </ScrollView>
          <View style = {{width: '100%'}}>
            <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
              <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Chairs</Text>
              <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
            </View>    
          </View>
          <ScrollView horizontal= {true} style={{width: width}}>
          <View style = {styles.horizontalChairs}>
            {chairsData.map((_, i) =>
              <View key={i} style={styles.row}>
                <View style={{paddingLeft: height * .02, paddingBottom: height * .02, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
                 <Tile
                    imageSrc={chairs[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .22}
                    height={width * .22}
                    onPress={this.handleClick.bind(this,'chair' + i)}
                  />
                </View>
              </View>
            )}
            </View>
            </ScrollView>
        <View style = {{width: '100%'}}>
          <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
            <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Tables</Text>
            <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
          </View>    
        </View>
        <ScrollView horizontal= {true} style={{width: width}}>
          <View style = {styles.horizontalTables}>
            {tablesData.map((_, i) =>
              <View key={i} style={styles.row}>
                <View style={{paddingLeft: height * .02, paddingBottom: height * .02, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
                 <Tile
                    imageSrc={tables[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .22}
                    height={width * .22}
                    onPress={this.handleClick.bind(this,'table' + i)}
                  />
                </View>
              </View>
            )}
            </View>
            </ScrollView>
        <View style = {{width: '100%'}}>
          <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
            <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Beds</Text>
            <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
        </View>    
      </View>
      <ScrollView horizontal= {true} style={{width: width}}>
          <View style = {styles.horizontalBeds}>
            {bedData.map((_, i) =>
              <View key={i} style={styles.row}>
                <View style={{paddingLeft: height * .02, paddingBottom: height * .02, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
                 <Tile
                    imageSrc={beds[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .22}
                    height={width * .22}
                    onPress={this.handleClick.bind(this,'bed' + i)}
                  />
                </View>
              </View>
            )}
            </View>
            </ScrollView>
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Cabinets</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
      <ScrollView horizontal= {true} style={{width: width}}>
          <View style = {styles.horizontalCabinets}>
            {cabinetData.map((_, i) =>
              <View key={i} style={styles.row}>
                <View style={{paddingLeft: height * .02, paddingBottom: height * .02, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
                 <Tile
                    imageSrc={cabinets[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .22}
                    height={width * .22}
                    onPress={this.handleClick.bind(this,'cabinet' + i)}
                  />
                </View>
              </View>
            )}
            </View>
            </ScrollView>
        <View style = {{width: '100%'}}>
      <View style = {{flex: 1, flexDirection: 'row', alignContent: 'center', alignItems: 'center', justifyContent: 'flex-start', paddingVertical: height * .03}}>
      <Text style = {{fontSize: subheaderFont, paddingHorizontal: width*.05, paddingBottom: 5,fontFamily: 'Product Sans', color: '#88888888'}}>Appliances</Text>
      <View style = {{height: 2, width: width*.7, backgroundColor: '#afafaf', alignSelf:'center'}}></View>    
      </View>    
      </View>
      <ScrollView horizontal= {true} style={{width: width}}>
          <View style = {styles.horizontalAppliances}>
            {applianceData.map((_, i) =>
              <View key={i} style={styles.row}>
                <View style={{paddingLeft: height * .02, paddingBottom: height * .02, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
                 <Tile
                    imageSrc={appliances[i]}
                    title = ""
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={width * .22}
                    height={width * .22}
                    onPress={this.handleClick.bind(this,'appliance' + i)}
                  />
                </View>
              </View>
            )}
            </View>
            </ScrollView>
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
        </Animated.View>
        <Animated.View style = {{position: 'absolute', backgroundColor:'#008fbec8',borderTopRightRadius: 15, borderTopLeftRadius: 15,top: -height * .05, width: width, height: height * .05}}>
            <Animated.View style = {{alignSelf: 'center',  transform: [{
                translateY: this.state.animatedStartValue.interpolate({
                  inputRange: [0, 1],
                  outputRange: [-height*.007 , 0]})
              }]
            }}>
              <Button 
                    title=""
                    icon={
                      <Icon
                        name="chevrons-up"
                        size={height * .03}
                        color="#ffffff"
                      />
                    }
                    buttonStyle={{backgroundColor: '#00000000', width: width, height: height* .05}}
                    containerStyle={{marginVertical: 0, height: height * .04}}
                    onPress={this.props.onOpen}
                    /> 
          </Animated.View>
        </Animated.View>
        <View style = {{position: 'absolute', top: 0, width: width, height: height * .05, shadowColor: '#00000087', shadowRadius: 5, shadowOpacity: 1,shadowOffset: {width: 0, height: 3}}}>
          <Button 
                title=""
                icon={
                  <Icon
                    name="chevrons-down"
                    size={height * .03}
                    color="#ffffff"
                  />
                }
                buttonStyle={{height: height * .05, width: width, backgroundColor: '#008fbec8'}}
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
    horizontalWide: {
      flex: 1,
      flexDirection: 'column',
      flexWrap: 'wrap',
      alignSelf: 'center',
      width: width * 2,
      height: height *.3
    },
    horizontalChairs: {
      flex: 1,
      flexDirection: 'column',
      flexWrap: 'wrap',
      alignSelf: 'center',
      width: width * 1.25,
      height: height *.4
    },
    horizontalTables: {
      flex: 1,
      flexDirection: 'column',
      flexWrap: 'wrap',
      alignSelf: 'center',
      width: width * 1.25,
      height: height *.4
    },
    horizontalBeds: {
      flex: 1,
      flexDirection: 'column',
      flexWrap: 'wrap',
      alignSelf: 'center',
      width: width * 1.25,
      height: height *.4
    },
    horizontalCabinets: {
      flex: 1,
      flexDirection: 'column',
      flexWrap: 'wrap',
      alignSelf: 'center',
      width: width * 1.5,
      height: height *.4
    },
    horizontalAppliances: {
      flex: 1,
      flexDirection: 'column',
      flexWrap: 'wrap',
      alignSelf: 'center',
      width: width * 1.75,
      height: height *.4
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