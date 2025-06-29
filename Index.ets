@Entry
@Component
struct Index {
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();
  @State listPosition: number = 0; // 0 means scrolling to the top of the List, 1 means intermediate value, and 2 means scrolling to the bottom of the List.

  getTime(index: number = 0) {
    let arr: string[] = []
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1 + index;
    const day = date.getDate();
    const week = date.getDay();
    // Example: Get the day of the week on Thursday, June 5, 2025
    const targetDate = new Date(year, month - 1, 1); // Note: Months are counted from 0 (5 for June)
    const dayIndex = targetDate.getDay(); // Back 4 (Thursday)
    const weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"
      , "Friday", "Saturday"];
    for (let i = 0; i < dayIndex; i++) {
      arr.push('')
    }
    // Get how many days there are in a month
    const days = new Date(year, month, 0).getDate();
    for (let i = 1; i < days + 1; i++) {
      arr.push(i + '')
    }
    return arr
  }

  aboutToAppear(): void {
    this.getTime()
  }

  build() {
    Column() {
      // Nav head navigation bar
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(28)
          .aspectRatio(1)
          .fillColor(Color.Black)
          .onClick(() => {

          })
        Text('Calendar')
          .fontSize(18)
        Column()
          .width(28)
      }
      .padding(8)
      .width('100%')
      .backgroundColor('#50cccccc')
      .justifyContent(FlexAlign.SpaceBetween)

      // Date arrangement
      Row() {
        Text('Sunday')
          .fontColor('#FF4A24')
        Text('Monday')
        Text('Tuesday')
        Text('Wednesday')
        Text('Thursday')
        Text('Friday')
        Text('Saturday')
          .fontColor('#FF4A24')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding(8)

      //Scroll through the calendar
      Scroll(this.scrollerForScroll) {
        Column() {
          CalenderComp({ arr: this.getTime(), index: 0 })
          CalenderComp({ arr: this.getTime(1), index: 1 })
          CalenderComp({ arr: this.getTime(2), index: 2 })
        }
      }
      .width("100%")
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
  }
}

@Component
struct CalenderComp {
  @Prop arr: string[] = []
  @Prop index: number = 0
  year: number = 0
  month: number = 0

  aboutToAppear(): void {
    this.year = (new Date()).getFullYear();
    this.month = (new Date()).getMonth() + 1 + this.index
  }

  build() {
    Column({ space: 5 }) {
      Text(this.year + 'year' + this.month + 'month')
        .fontSize(18)
        .width('100%')
        .padding(8)
        .textAlign(TextAlign.Center)
      //   dividingLine
      Divider()
        .color(Color.Red)
        .strokeWidth(2)
        .margin({ top: 1, bottom: 10 })
      Grid() {
        ForEach(this.arr, (item: number) => {
          GridItem() {
            Text(item.toString())
              .fontSize(16)
              .textAlign(TextAlign.Center)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    }
  }
}