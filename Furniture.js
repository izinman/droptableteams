import React, {Component} from 'react';
import { StyleSheet, Text, ScrollView, View, Image} from 'react-native'
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
    this.setState({start: 1});
  }
    render() {
        if(this.state.start == 0){
        return(
            
            <View>
            <ScrollView styles={styles.container} >
            <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
              <View style={styles.container1}>
                <Tile
                    imageSrc={{ uri: this.props.src }}
                    title = {this.props.name}
                    titleStyle={{ fontSize: 30, fontWeight: 'bold' }}
                    featured
                    activeOpacity={.75}
                    width={410}
                    onPress={this.handleClick}
              />
              </View>
            </ScrollView>
            <View style={{position: 'absolute', bottom: 20 ,alignSelf: 'center' }}>
              <Button     
                title={"design"}
                ViewComponent={require('react-native-linear-gradient').default}
                titleStyle={{fontWeight: 'bold', fontSize: 12}}
                linearGradientProps={{
                  colors: ['#0064e8', '#00ffed'],
                  start: [1, 0],
                  end: [0.2, 0],
                }}
                buttonStyle={{borderWidth: 0, borderColor: 'transparent', borderRadius: 20, height: 45}}
                containerStyle={{marginVertical: 10, height: 40, width: 300, alignSelf: 'center'}}
                onPress = {this.handleClick}
                /> 
              </View>
           </View>
               
            );
            
        }
        else{
            return (
                <ARScene/>
            );
        }
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: "#f2f245",
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        alignSelf: 'center',
        flexWrap: 'wrap',
        paddingTop: 150
      },
    container1: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        alignSelf: 'center'
    },
    image:{
        height: 75,
        width: 150,
        marginTop: 5,
        marginLeft: 5,
        marginRight: 5,
        marginBottom: 5
    }
  });

  /*
  
  */