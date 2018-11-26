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
    if(this.state.start == 0){
    return (
      <View>
        <ScrollView styles={styles.container} >
              <Design src="https://rocheledecorating.com.au/website-images/modernhome.jpg" name="modern"/>
              <Design src="https://rocheledecorating.com.au/website-images/Open_Plan_Bedroom_Decorate_Design1.jpg" name="contemporary"/>  
              <Design src="https://rocheledecorating.com.au/website-images/property_styling_brisbane_2.jpg" name="minimalist"/>  
              <Design src="https://rocheledecorating.com.au/website-images/Warehouse_Lounge_Dining_Decorate_Design1.jpg" name ="industrial"/>  
              <Design src="https://rocheledecorating.com.au/website-images/Nundah_Rochele_Decorating_2.jpg" name="mid-century modern"/>  
              <Design src="https://rocheledecorating.com.au/website-images/Scandinavian_design.jpg"name="scandanavian"/>  
              <Design src="https://rocheledecorating.com.au/website-images/Art_Deco_House_Decorate_Design8.jpg" name="traditional"/>  
              <Design src="https://rocheledecorating.com.au/website-images/Hawthorne_interior_design_24.jpg" name="transitional"/>  
              <Design src="https://rocheledecorating.com.au/website-images/Hawthorne_Interior_Designer_Rochele_48.jpg" name="bohemian"/>
        </ScrollView>
        <View style={{position: 'absolute', bottom: 20 ,alignSelf: 'center' }}>
          <Button     
            title={instruction}
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
      return(
        <ARScene/>
      );
    }
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#f2f245",
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center'
  },
});

      