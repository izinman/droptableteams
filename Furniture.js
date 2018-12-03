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
                    imageSrc={{ uri: "https://www.ikea.com/us/en/images/products/ekedalen-chair-brown__0516603_PE640439_S4.JPG" }}
                    title = "chair"
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
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
                    titleStyle={{ fontSize: 14, fontWeight: 'bold'}}
                    featured
                    activeOpacity={.75}
                    width={150}
                    onPress={this.handleClick}
              />
              </View>
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
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
              <View style={{padding: 10}}>
                <Tile
                    imageSrc={{ uri: "data:image/jpeg;base64,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"}}
                    title = "sectional"
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